FROM lsiobase/alpine:3.16 as build

ENV \
    HOME=/config \
    CONMAN_VERSION=0.3.0 \
    LIBSOCKET_VERSION=2.5.0 \
    TZ=UTC

WORKDIR /src/

RUN \
    echo "*** install build packages ***" && \
    apk add --no-cache wget tar gcc g++ autoconf cmake make musl-dev && \
    apk add freeipmi-dev --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community && \
    echo "*** Build libsocket ***" && \
        cd /src && \
        wget -O - https://github.com/dermesser/libsocket/archive/refs/tags/v2.5.0.tar.gz  | tar xzf - && \
        cd libsocket-${LIBSOCKET_VERSION} && \
        mkdir build && cd build && \
        cmake .. && \
        make socket && \
        install -c -s C/libsocket.so /usr/lib && \
    echo "*** Build conman ***" && \
        cd /src && \
        wget -q -O - https://github.com/dun/conman/releases/download/conman-${CONMAN_VERSION}/conman-${CONMAN_VERSION}.tar.xz | tar xJf - && \
        cd conman-${CONMAN_VERSION} && \
        ./configure --with-freeipmi && \
        make install

FROM lsiobase/alpine:3.16

ENV \
    HOME=/config \
    TZ=UTC

RUN \
	echo "**** install packages ****" && \
	apk add --no-cache logrotate && \
        apk add freeipmi --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community

COPY --from=build /usr/local /usr/local
COPY --from=build /usr/lib/libsocket.so /usr/lib/libsocket.so

COPY root /

EXPOSE 7890

VOLUME ["/config", "/logs"]
