FROM golang:1.21
WORKDIR "/build"
RUN wget https://nodejs.org/dist/v18.20.4/node-v18.20.4-linux-x64.tar.gz \
    && tar -xvf node-v18.20.4-linux-x64.tar.gz \
    && rm node-v18.20.4-linux-x64.tar.gz \
    && mv node-v18.20.4-linux-x64/ /usr/local/nodejs \
    && echo 'export PATH=$PATH:/usr/local/nodejs/bin' >> /root/.bashrc \
    && /bin/bash -c "source /root/.bashrc && npm install pnpm -g" \
    && apt update \
    && apt install -y zip \
    && apt -y install gcc-mingw-w64-x86-64 \
    && apt -y install gcc-arm-linux-gnueabihf libc6-dev-armhf-cross \
    && apt -y install gcc-aarch64-linux-gnu libc6-dev-arm64-cross