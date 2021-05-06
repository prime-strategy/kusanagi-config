FROM alpine:3.13.5
LABEL maintainer="kusanagi@prime-strategy.co.jp"

RUN apk add --no-cache tar mariadb-client postgresql-client git \
    && addgroup -g 1000 kusanagi \
    && adduser -h /home/kusanagi -s /bin/false -u 1000 -G kusanagi -D kusanagi

COPY files/my.cnf /etc/my.cnf 

RUN apk add --no-cache --virtual .curl curl \
	&& TRIVY_VERSION=0.16.0 \
	&& curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v$TRIVY_VERSION \
    && trivy filesystem --exit-code 1 --no-progress / \
    && apk del .curl \
    && :

USER kusanagi
