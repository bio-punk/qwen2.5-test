#!/bin/bash

# cd /workspace/Pai-Megatron-Patch/toolkits/distributed_checkpoints_convertor
# bash scripts/qwen2_5/run_8xH20.sh \
# 32B \
# /data/Qwen2.5-32B-Instruct \
# /data/Qwen2.5-32B-Instruct-to-mcore  \
# false \
# true \
# bf16

cd /data/llamafactory
export NCCL_IB_RETRY_CNT="13" 
export NCCL_IB_TIMEOUT="22"
export NCCL_DEBUG="WARN"
export NCCL_IB_HCA="mlx5_0:1,mlx5_1:1,mlx5_2:1,mlx5_3:1" 
export NCCL_IB_P2P_DISABLE="0" 
export NCCL_IB_DISABLE="0"
export NCCL_SOCKET_IFNAME=eth0
export OMP_NUM_THREADS=8
export UB_SKIPMC=1

export NNODES=2 
export NODE_RANK=$1
export MASTER_ADDR=192.168.0.200 
export MASTER_PORT=29500
export PYTHONPATH=/data/llamafactory/Pai-Megatron-Patch/Megatron-LM-250328:$PYTHONPATH
export PYTHONPATH=/data/llamafactory/Pai-Megatron-Patch/Bigcode-Evaluation-Harness-240327:$PYTHONPATH
export PYTHONPATH=/data/llamafactory/Pai-Megatron-Patch:$PYTHONPATH
bash run_mcore_qwen.sh  \
dlc  \
32B   \
1    \
1 \
1e-7   \
1e-8   \
128  \
128  \
bf16  \
8 \
2  \
1 \
true \
true   \
true \
false \
false   \
false \
100000  \
/data/qwen-datasets/wudao_qwenbpe_text_document \
/data/qwen-datasets/wudao_qwenbpe_text_document \
/data/Qwen2.5-32B-Instruct-to-mcore  \
10000  \
100   \
/data/llamafactory/output_mcore_qwen2.5_pretrain
