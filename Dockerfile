FROM alpine:3.14.0
LABEL maintainer="kusanagi@prime-strategy.co.jp"

COPY files/my.cnf /etc/my.cnf 

RUN apk update \
    && apk upgrade apk-tools \
    && apk add --no-cache tar mariadb-client postgresql-client git \
    && addgroup -g 1000 kusanagi \
    && adduser -h /home/kusanagi -s /bin/false -u 1000 -G kusanagi -D kusanagi \
    && apk add --no-cache --virtual .curl curl \
	&& curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin \
    && trivy filesystem --exit-code 1 --no-progress / \
    && apk del .curl \
    && rm /usr/local/bin/trivy \
    && :

USER kusanagi
