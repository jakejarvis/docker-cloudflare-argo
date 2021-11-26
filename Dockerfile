FROM docker.io/ubuntu:focal

LABEL maintainer="Jake Jarvis <jake@jarv.is>"
LABEL repository="https://github.com/jakejarvis/docker-cloudflare-argo"

# https://docs.github.com/en/free-pro-team@latest/packages/managing-container-images-with-github-container-registry/connecting-a-repository-to-a-container-image#connecting-a-repository-to-a-container-image-on-the-command-line
LABEL org.opencontainers.image.source="https://github.com/jakejarvis/docker-cloudflare-argo"

ARG CLOUDFLARED_VERSION
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN ARCH="" && \
    case $(uname -m) in \
        x86_64) ARCH="amd64" ;; \
        aarch64) ARCH="arm64" ;; \
        *) echo "Unknown build architecture $(uname -m), quitting."; exit 2 ;; \
    esac && \
    wget -q https://github.com/cloudflare/cloudflared/releases/download/${CLOUDFLARED_VERSION:-../latest/download}/cloudflared-linux-${ARCH}.deb && \
    dpkg -i cloudflared-linux-${ARCH}.deb && \
    rm cloudflared-linux-${ARCH}.deb && \
    cloudflared --version

ENTRYPOINT ["cloudflared", "tunnel"]
