FROM ghcr.io/quorinex/freebuff2api:latest

# ===== Freebuff2API Configuration =====
ENV LISTEN_ADDR=:8080
ENV UPSTREAM_BASE_URL=https://www.codebuff.com
ENV AUTH_TOKENS=0f7b570a-91b9-4dc2-97c5-efc1db0d136d
ENV ROTATION_INTERVAL=6h
ENV REQUEST_TIMEOUT=15m
ENV API_KEYS=
ENV HTTP_PROXY=

EXPOSE 8080

ENTRYPOINT ["Freebuff2API"]
