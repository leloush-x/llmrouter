# syntax=docker/dockerfile:1
# OmniRoute on Railway — thin layer over the official prebuilt multi-arch image.
# No source build = fast deploys. Pin for stability: diegosouzapw/omniroute:3.8.49
FROM diegosouzapw/omniroute:latest

# Base image already sets NODE_ENV, PORT, HOSTNAME, DATA_DIR and its own
# HEALTHCHECK (/api/monitoring/health). We only tune what differs:
ENV \
    # Heap ceiling — base default is 1024MB. Lower = lighter on Railway plans.
    OMNIROUTE_MEMORY_MB=384 \
    # Railway terminates HTTPS at the edge; cookies must be Secure.
    AUTH_COOKIE_SECURE=true

# Railway volumes mount root-owned, but this image runs as UID 1000 ("node")
# and cannot write to /app/data -> crash on boot. Start as root, fix ownership,
# then drop back to node before launching the server (same CMD as upstream).
COPY <<'EOF' /usr/local/bin/railway-entry.sh
#!/bin/sh
set -e
if [ "$(id -u)" = "0" ]; then
  mkdir -p /app/data
  chown -R node:node /app/data 2>/dev/null || true
  if command -v setpriv >/dev/null 2>&1; then
    exec setpriv --reuid=node --regid=node --clear-groups node dev/run-standalone.mjs
  fi
fi
exec node dev/run-standalone.mjs
EOF
RUN chmod +x /usr/local/bin/railway-entry.sh

EXPOSE 20128
ENTRYPOINT ["/usr/local/bin/railway-entry.sh"]
