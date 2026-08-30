# OmniRoute (Bun) — Koyeb / any Docker host
# Image: ghcr.io/diegosouzapw/omniroute:main-bun
# Listens on 0.0.0.0:8000
#
#   docker build -t omniroute .
#   docker run --rm -p 8000:8000 omniroute

FROM ghcr.io/diegosouzapw/omniroute:main-bun

LABEL org.opencontainers.image.title="omniroute" \
      org.opencontainers.image.description="OmniRoute AI gateway (Bun) — 0.0.0.0:8000" \
      org.opencontainers.image.source="https://github.com/diegosouzapw/OmniRoute" \
      org.opencontainers.image.licenses="MIT"

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      nodejs \
      npm \
      curl \
      ca-certificates \
      openssh-server \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /app/data /var/run/sshd /run/sshd \
 && ssh-keygen -A \
 && printf '%s\n' \
      'Port 22' \
      'ListenAddress 0.0.0.0' \
      'PermitRootLogin no' \
      'PasswordAuthentication no' \
      'PubkeyAuthentication yes' \
      > /etc/ssh/sshd_config \
 && chown -R bun:bun /app/data

ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    HOSTNAME=0.0.0.0 \
    OMNIROUTE_SERVER_HOST=0.0.0.0 \
    PORT=8000 \
    OMNIROUTE_PORT=8000 \
    DATA_DIR=/app/data \
    NEXT_TELEMETRY_DISABLED=1 \
    OMNIROUTE_MEMORY_MB=500 \
    CONTAINER_HOST=docker

EXPOSE 8000
VOLUME ["/app/data"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -fsS http://127.0.0.1:8000/ >/dev/null || exit 1

USER bun
