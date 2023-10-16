FROM --platform=$BUILDPLATFORM alpine:3.18.3
LABEL maintainer="kusanagi@prime-strategy.co.jp"

COPY files/my.cnf /etc/my.cnf 

RUN : \
    && apk add --no-cache  \
        tar \
        mariadb-client \
        postgresql-client \
        git \
        curl=8.4.0-r0 \
        libssl3=3.1.2-r0 \
        libcrypto3=3.1.2-r0 \
        expat \
    && addgroup -g 1000 kusanagi \
    && adduser -h /home/kusanagi -s /bin/false -u 1000 -G kusanagi -D kusanagi \
    && apk add --no-cache --virtual .curl curl \
    && curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /tmp \
    && /tmp/trivy filesystem --skip-files /tmp/trivy --exit-code 1 --no-progress / \
    && apk del .curl \
    && rm /tmp/trivy \
    && :

USER kusanagi
