FROM marketplace.gcr.io/google/ubuntu1804
LABEL maintainer="Jake Jarvis <jake@jarv.is>"

#RUN apt-get update \
# && apt-get install -y --no-install-recommends wget ca-certificates \
# && rm -rf /var/lib/apt/lists/*

RUN curl -o cloudflared.tgz https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz \
 && tar -zxvf cloudflared.tgz -C ./ \
 && rm cloudflared.tgz \
 && chmod +x cloudflared

ENTRYPOINT ["sh", "-c", "./cloudflared tunnel --loglevel info --no-autoupdate"]
