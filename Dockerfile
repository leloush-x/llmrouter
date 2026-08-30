FROM cgr.dev/chainguard/wolfi-base

RUN apk add --no-cache nodejs npm git curl openssh python 

WORKDIR /app
RUN git clone --depth 1 https://github.com/diegosouzapw/OmniRoute.git .
RUN npm install

ENV HOST=0.0.0.0
ENV PORT=8080
EXPOSE 8080

CMD ["npx", "omniroute"]
