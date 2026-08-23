FROM alpine:latest

ENV NODE_ENV=production \
    PORT=20128 \
    HOSTNAME=0.0.0.0 \
    DATA_DIR=/app/data \
    OMNIROUTE_MEMORY_MB=384 \
    AUTH_COOKIE_SECURE=true

WORKDIR /app

# Install Node.js, npm, and dependencies for native compilation and Bun
RUN apk update && \
    apk add --no-cache nodejs npm bash curl unzip make gcc g++ python3 linux-headers

# Install OmniRoute globally
RUN npm install -g omniroute

# Setup persistence directory
RUN mkdir -p /app/data

EXPOSE 20128

CMD ["omniroute"]
