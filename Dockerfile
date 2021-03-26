FROM alpine:3.13.3
LABEL maintainer="kusanagi@prime-strategy.co.jp"

RUN apk add --no-cache tar mariadb-client postgresql-client git \
&& addgroup -g 1000 kusanagi \
&& adduser -h /home/kusanagi -s /bin/false -u 1000 -G kusanagi -D kusanagi

COPY files/my.cnf /etc/my.cnf 

RUN apk add --no-cache --virtual .curl curl \
    && curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/master/contrib/install.sh | sh -s -- -b /usr/local/bin \
    && trivy filesystem --exit-code 1 --no-progress / \
    && apk del .curl \
    && :

USER kusanagi
