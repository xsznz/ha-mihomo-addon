
FROM alpine:3.22

RUN apk add --no-cache ca-certificates

WORKDIR /app

ARG MIHOMO_VERSION=v1.19.34
ARG MIHOMO_SHA256=0c07340a01408d033dda4088ea2a4c1e4d82aeed7b2f84f7c046e93b6ff3290c

RUN wget -O /tmp/mihomo.gz \
    "https://github.com/MetaCubeX/mihomo/releases/download/${MIHOMO_VERSION}/mihomo-linux-amd64-v1-${MIHOMO_VERSION}.gz" \
    && echo "${MIHOMO_SHA256}  /tmp/mihomo.gz" | sha256sum -c - \
    && gzip -d /tmp/mihomo.gz \
    && mv /tmp/mihomo /usr/local/bin/mihomo \
    && chmod +x /usr/local/bin/mihomo

ENTRYPOINT ["/usr/local/bin/mihomo"]
