FROM lsiobase/ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

ENV \
	HOME=/config \
	TZ=UTC

RUN \
	echo "**** install packages ****" && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		conman && \
	echo "**** clean up ****" && \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

COPY root /

EXPOSE 7890

VOLUME ["/config", "/logs"]
