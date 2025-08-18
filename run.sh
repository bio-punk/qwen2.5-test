#!/bin/bash

# docker run -itd --runtime=nvidia --gpus all --device=/dev/infiniband --shm-size 1024G --ulimit memlock=-1  --network overlay01 --ip 192.168.0.100 -v /data:/data -v /root:/root -v /root/.ssh/:/root/.ssh/ 99a
# ssh gpu72 "docker run -itd --runtime=nvidia --gpus all --device=/dev/infiniband --shm-size 1024G --ulimit memlock=-1  --network overlay01 --ip 192.168.0.101 -v /data:/data -v /root:/root -v /root/.ssh/:/root/.ssh/ 99a"
# docker exec -it `docker ps -q` bash /data/llamafactory/run.sh 0 2>&1|tee pt_lorarank8_zero2ol_noderank0_gpu64.log
# docker exec -it `docker ps -q` bash /data/llamafactory/run.sh 1 2>&1|tee pt_lorarank8_zero2ol_noderank1_gpu72.log
docker run -itd --runtime=nvidia --gpus all --device=/dev/infiniband --shm-size 1024G --ulimit memlock=-1  --network overlay01 --ip 192.168.0.200 -v /data:/data -v /root:/root -v /root/.ssh/:/root/.ssh/ 101
ssh gpu72 "docker run -itd --runtime=nvidia --gpus all --device=/dev/infiniband --shm-size 1024G --ulimit memlock=-1  --network overlay01 --ip 192.168.0.201 -v /data:/data -v /root:/root -v /root/.ssh/:/root/.ssh/ 101"
d /data/llamafactory

export NCCL_IB_RETRY_CNT="13" 
export NCCL_IB_TIMEOUT="22"
export NCCL_DEBUG="INFO"
export NCCL_IB_HCA="mlx5_0:1,mlx5_1:1,mlx5_2:1,mlx5_3:1" 
export NCCL_IB_P2P_DISABLE="0" 
export NCCL_IB_DISABLE="0"
export NCCL_SOCKET_IFNAME=eth0
export OMP_NUM_THREADS=8

FORCE_TORCHRUN=1 NNODES=2 NODE_RANK=$1 MASTER_ADDR=192.168.0.100 MASTER_PORT=29500 llamafactory-cli train run.yaml
