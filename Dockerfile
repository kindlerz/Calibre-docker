ARG VERSION=3.13.18-slim

FROM python:${VERSION}

ENV DEBIAN_FRONTEND=noninteractive
# Calibre's PDF output runs Chromium, which refuses to start as root with its sandbox
ENV QTWEBENGINE_CHROMIUM_FLAGS=--no-sandbox

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget unzip xz-utils fonts-liberation fonts-noto-core fonts-ebgaramond calibre nodejs npm curl clang && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deno.land/install.sh -o install.sh && \
    sh install.sh && \
    rm install.sh
ENV DENO_INSTALL="/root/.deno"
ENV PATH="$DENO_INSTALL/bin:$PATH"
RUN deno --version
