FROM debian:jessie
MAINTAINER Mike Dillon <mike.dillon@synctree.com>

# XXX: Workaround for https://github.com/docker/docker/issues/6345
RUN ln -s -f /bin/true /usr/bin/chfn

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            coturn \
            curl \
            procps \
            --no-install-recommends
RUN mkdir -p /usr/local/coturn/etc && \
    mkdir -p /usr/local/coturn/var/log && \
    mv /etc/turnserver.conf /usr/local/coturn/etc/ && \
    mv /etc/turnuserdb.conf /usr/local/coturn/etc/


# ADD turnserver.sh /turnserver.sh

VOLUME /usr/local/coturn/ 

EXPOSE 3478 3478/udp
# CMD ["/bin/sh", "/usr/bin/turnserver -c /usr/local/coturn/etc/turnserver.conf"]
CMD ["/bin/bash", "-c", "/usr/bin/turnserver -c /usr/local/coturn/etc/turnserver.conf"]

