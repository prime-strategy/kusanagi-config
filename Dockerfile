FROM alpine:3.12.1
MAINTAINER kusanagi@prime-strategy.co.jp

RUN apk add --no-cache tar mariadb-client postgresql-client git \
&& addgroup -g 1000 kusanagi \
&& adduser -h /home/kusanagi -s /bin/false -u 1000 -G kusanagi -D kusanagi

COPY files/my.cnf /etc/my.cnf 

USER kusanagi
