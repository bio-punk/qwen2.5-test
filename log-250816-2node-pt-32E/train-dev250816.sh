#!/bin/bash
#SBATCH -N 2
#SBATCH -x g0010
#SBATCH --gres=gpu:8
#SBATCH --job-name=wzk0816
#SBATCH --output=llama3_lora_sft_%j.log
#SABTCH --error=llama3_lora_sft_%j.log
#SBATCH --time=24:00:00
#SBATCH --qos=gpugpu
#SBATCH

export MASTER_PORT=29500

module load cuda/12.1
module load miniconda/4.11.0
module load gcc/9.4.0-gcc-4.8.5
source activate qwen32b 
# if running on single node, use the following command:
# llamafactory-cli train examples/train_lora/llama3_lora_sft.yaml

export NCCL_DEBUG=INFO
export NCCL_IB_DISABLE=0
export NCCL_IB_HCA=mlx5_0:1
export NCCL_IB_GID_INDEX=3
export NCCL_IB_TIMEOUT=23
export NCCL_IB_RETRY_COUNT=7
export NCCL_P2P_DISABLE=0

export OMP_NUM_THREADS=6

HOSTFILE=/tmp/llama3_lora_sft_nodes.txt

for nodename in $(scontrol show hostnames $SLURM_JOB_NODELIST); do
    echo "Running on node: $nodename"
    echo ${nodename} >> ${HOSTFILE}
done

export MASTER_ADDR=$(head -n 1 ${HOSTFILE})
GPUS_PER_NODE=`nvidia-smi -L | wc -l`
export WORLD_SIZE=$(($GPUS_PER_NODE * $SLURM_NNODES))

echo "------------------------------------------------"
echo "MASTER_ADDR: ${MASTER_ADDR}"
echo "GPUS_PER_NODE: ${GPUS_PER_NODE}"
echo "WORLD_SIZE: ${WORLD_SIZE}"
echo "SLURM_NNODES: ${SLURM_NNODES}"
echo "SLURM_JOBID: ${SLURM_JOBID}"
echo "HOSTFILE: ${HOSTFILE}"
cat ${HOSTFILE}
echo "------------------------------------------------"

idx=0
for nodename in $(cat ${HOSTFILE}); do
    LOG_FILE="llama3_lora_sft_${SLURM_JOBID}_${nodename}.log"
    echo "Node: $nodename, GPUs: $GPUS_PER_NODE, Log: $LOG_FILE"
    export FORCE_TORCHRUN=1
    export NNODES="${SLURM_NNODES}"
    export NODE_RANK="${idx}"
    export MASTER_ADDR="${MASTER_ADDR}"
    export MASTER_PORT="${MASTER_PORT}"
    cmd="srun -w "${nodename}" -N 1 llamafactory-cli train ./ls2node.yaml"
    echo "Executing command: $cmd"
    let idx+=1
    if [ $idx -eq $SLURM_NNODES ]; then
        echo "Waiting for the last node to finish..."
        echo "Starting training on node $nodename in foreground..."
        ${cmd} 1>${LOG_FILE} 2>&1
        echo "Training completed on all nodes."
    else
        echo "Starting training on node $nodename in background..."
        ${cmd} 1>${LOG_FILE} 2>&1 &
        echo "Training started on node $nodename in background."
    fi
done
