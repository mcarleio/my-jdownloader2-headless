FROM openjdk:8-jre

MAINTAINER mcarleio <hi@mcarle.io>

RUN set +x && \
	apt-get update && \
	apt-get install -y jq openvpn expect procps && \
	mkdir -p /opt/jd/cfg && \
	mkdir -p /opt/jd/libs && \
	wget -O /opt/jd/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar && \
	adduser --disabled-password --gecos "JDownloader" jdownloader --quiet && \
	mkdir /home/jdownloader/Downloads && \
	chown jdownloader:jdownloader /home/jdownloader/Downloads

COPY ./entrypoint.sh /
COPY ./openvpn.sh /
COPY ./jd.sh /
COPY ./start.sh /

VOLUME /opt/jd/cfg
VOLUME /home/jdownloader/Downloads

CMD ["/entrypoint.sh"]
