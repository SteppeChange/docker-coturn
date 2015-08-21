FROM debian:jessie
MAINTAINER Mike Dillon <ogolosovskiy@gmail.com>

# XXX: Workaround for https://github.com/docker/docker/issues/6345
RUN ln -s -f /bin/true /usr/bin/chfn

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            coturn \
            curl \
            procps \
            --no-install-recommends
RUN mkdir -p /opt/coturn/etc && \
    mkdir -p /opt/coturn/var/log && \
    mv /etc/turnserver.conf /opt/coturn/etc/ && \
    mv /etc/turnuserdb.conf /opt/coturn/etc/

# ADD turnserver.sh /turnserver.sh

VOLUME /opt/coturn/ 

EXPOSE 3478 3478/udp
# CMD ["/bin/sh", "/usr/bin/turnserver -c /opt/coturn/etc/turnserver.conf"]
CMD ["/bin/bash", "-c", "/usr/bin/turnserver -c /opt/coturn/etc/turnserver.conf"]

