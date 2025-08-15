FROM llamafactory-wzk:2025.08.15 AS base
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
ENV NCCL_IB_RETRY_CNT="13" NCCL_IB_TIMEOUT="22" \
    NCCL_DEBUG="WARN" \
    NCCL_IB_HCA="mlx5_0:1,mlx5_1:1,mlx5_2:1,mlx5_3:1" \
    NCCL_IB_P2P_DISABLE="0" \
    NCCL_IB_DISABLE="0"
RUN pip install deepspeed==0.16.9
