FROM alpine:3.15.0
LABEL maintainer="kusanagi@prime-strategy.co.jp"

COPY files/my.cnf /etc/my.cnf 

RUN apk update \
    && apk add --no-cache tar mariadb-client postgresql-client git \
    && addgroup -g 1000 kusanagi \
    && adduser -h /home/kusanagi -s /bin/false -u 1000 -G kusanagi -D kusanagi \
    && apk add --no-cache --virtual .curl curl \
	&& curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /tmp \
    && /tmp/trivy filesystem --skip-files /tmp/trivy --exit-code 1 --no-progress / \
    && apk del .curl \
    && rm /tmp/trivy \
    && :

USER kusanagi
