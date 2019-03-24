FROM ubuntu:18.04
LABEL maintainer="Jake Jarvis <jake@jarv.is>"

RUN apt-get update \
 && apt-get install -y --no-install-recommends wget ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN wget -O cloudflared.tgz https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz \
 && tar -xzvf cloudflared.tgz \
 && rm cloudflared.tgz \
 && chmod +x cloudflared

ENTRYPOINT ["./cloudflared", "tunnel"]
