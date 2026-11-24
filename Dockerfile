
FROM alpine:3.22

RUN apk add --no-cache ca-certificates bash

WORKDIR /app

ARG BUILD_VERSION=1.0.0
ARG MIHOMO_VERSION=v1.19.34
ARG MIHOMO_SHA256=0c07340a01408d033dda4088ea2a4c1e4d82aeed7b2f84f7c046e93b6ff3290c

RUN wget -O /tmp/mihomo.gz \
    "https://github.com/MetaCubeX/mihomo/releases/download/${MIHOMO_VERSION}/mihomo-linux-amd64-v1-${MIHOMO_VERSION}.gz" \
    && echo "${MIHOMO_SHA256}  /tmp/mihomo.gz" | sha256sum -c - \
    && gzip -d /tmp/mihomo.gz \
    && mv /tmp/mihomo /app/mihomo \
    && chmod +x /app/mihomo

COPY start-mihomo.sh /app/start-mihomo.sh
COPY mihomo-default.yaml /app/mihomo-default.yaml

RUN chmod +x /app/start-mihomo.sh

LABEL \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.type="app" \
    io.hass.arch="amd64"

CMD ["/app/start-mihomo.sh"]
