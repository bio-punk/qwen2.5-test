FROM dsw-registry.cn-wulanchabu.cr.aliyuncs.com/pai/pai-megatron-patch:25.04 AS base
ENV DEBIAN_FRONTEND=noninteractive
RUN cd /workspace && \
    git clone --recurse-submodules -b v0.11.1 https://github.com/alibaba/Pai-Megatron-Patch.git
ENV PYTHONPATH=/workspace/Pai-Megatron-Patch:$PYTHONPATH