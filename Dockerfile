FROM --platform=$BUILDPLATFORM alpine:3.21.2
LABEL maintainer="kusanagi@prime-strategy.co.jp"

COPY files/my.cnf /etc/my.cnf 

RUN : \
    && apk add --no-cache  \
        tar \
        mariadb-client \
        postgresql16-client \
        git=2.48.1-r0 \
        libcurl=8.11.1-r0 \
        libssl3=3.3.2-r4 \
        libcrypto3=3.3.2-r4 \
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
