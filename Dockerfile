FROM openjdk:8-jre-alpine

MAINTAINER mcarleio <hi@mcarle.io>

RUN set -x && \
	apk add --no-cache jq && \
	mkdir -p /opt/jd/cfg && \
	wget -O /opt/jd/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar && \
	adduser -D -g "JDownloader" jdownloader && \
	mkdir /home/jdownloader/Downloads && \
	chown jdownloader:jdownloader /home/jdownloader/Downloads

COPY ./entrypoint.sh /

VOLUME /opt/jd/cfg
VOLUME /home/jdownloader/Downloads

CMD ["/entrypoint.sh"]
