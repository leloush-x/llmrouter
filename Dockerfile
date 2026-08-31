FROM diegosouzapw/omniroute:latest

ENV DATA_DIR=/app/data \
    OMNIROUTE_MEMORY_MB=1024

EXPOSE 20128
VOLUME ["/app/data"]
