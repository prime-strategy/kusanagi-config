FROM --platform=$BUILDPLATFORM alpine:3.24.3
LABEL maintainer="kusanagi@prime-strategy.co.jp"

COPY files/my.cnf /etc/my.cnf 

RUN : \
    && apk upgrade --no-cache \
        musl \
        musl-utils \
        busybox \
        curl \
        libcrypto3 \
        zlib \
    && apk add --no-cache \
        tar \
        mariadb-client \
        postgresql16-client \
        git \
        expat \
    && addgroup -g 1000 kusanagi \
    && adduser -h /home/kusanagi -s /bin/false -u 1000 -G kusanagi -D kusanagi \
    && :

USER kusanagi
