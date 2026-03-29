# 使用轻量级的 Python 3.11 镜像作为基础
FROM python:3.11-slim

# 安装 C++ 编译器 (g++)
RUN apt-get update && \
    apt-get install -y g++ && \
    rm -rf /var/lib/apt/lists/*

# 设置容器内的工作目录
WORKDIR /data

# 容器启动时的默认行为（可选）
CMD ["/bin/bash"]