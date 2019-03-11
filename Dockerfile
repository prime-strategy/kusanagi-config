FROM alpine:3.9
MAINTAINER kusanagi@prime-strategy.co.jp

RUN apk add --no-cache tar mariadb-client postgresql-client \
&& addgroup -g 1000 kusanagi \
&& adduser -h /home/kusanagi -s /bin/false -u 1000 -G kusanagi -D kusanagi

COPY files/my.cnf /etc/my.cnf 

ARG MICROSCANNER_TOKEN
RUN if [ x${MICROSCANNER_TOKEN} != x ] ; then \
	apk add --no-cache --virtual .ca ca-certificates \
	&& update-ca-certificates\
	&& wget --no-check-certificate https://get.aquasec.com/microscanner \
	&& chmod +x microscanner \
	&& ./microscanner ${MICROSCANNER_TOKEN} || exit 1\
	&& rm ./microscanner \
	&& apk del --purge --virtual .ca ;\
    fi

USER kusanagi
