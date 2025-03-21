FROM golang:1.21

WORKDIR /build

# 设置环境变量（替代 bashrc 方案）
ENV PATH="/usr/local/nodejs/bin:${PATH}"

# 合并安装操作到单个 RUN 层
RUN wget https://nodejs.org/dist/v18.20.5/node-v18.20.5-linux-x64.tar.gz \
    && tar -xvf node-v18.20.5-linux-x64.tar.gz \
    && mv node-v18.20.5-linux-x64/ /usr/local/nodejs \
    && rm node-v18.20.5-linux-x64.tar.gz \
    && /usr/local/nodejs/bin/npm install pnpm -g \
    # 合并 apt 安装操作
    && apt update \
    && apt install -y \
        zip \
        gcc-mingw-w64-x86-64 \
        gcc-arm-linux-gnueabihf \
        libc6-dev-armhf-cross \
        gcc-aarch64-linux-gnu \
        libc6-dev-arm64-cross \
    # 清理缓存和临时文件
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*