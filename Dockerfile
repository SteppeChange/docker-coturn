FROM debian:jessie
MAINTAINER Mike Dillon <ogolosovskiy@gmail.com>

# XXX: Workaround for https://github.com/docker/docker/issues/6345
RUN ln -s -f /bin/true /usr/bin/chfn

#base
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    	    apt-utils \
	    sudo \
            curl \
            procps \
            --no-install-recommends

# coTurn + mongo driver pre req
RUN yes | apt-get install \
    	    build-essential \
	    automake \
	    autoconf \
	    libtool \
	    libssl-dev \
	    libevent-dev \
	    git

# install driver
RUN cd ~ && \
    git clone https://github.com/mongodb/mongo-c-driver.git && \
    cd mongo-c-driver && \
    ./autogen.sh && \
    make && \
    sudo make install && \
    cd ~


# install coTurn
RUN cd ~ && \
    git clone https://github.com/ogolosovskiy/coturn.git && \
    cd coturn && \
    ./configure && \
    make && \
    sudo make install && \
    mkdir -p /opt/coturn/etc && \
    mkdir -p /opt/coturn/var/log && \
    mv ./mac/turnserver.conf /opt/coturn/etc/ && \
    cd ~

VOLUME /opt/coturn/ 

declare -x EXTERNAL_IP="79.173.86.242"
declare -x MIN_PORT=40000
declare -x MAX_PORT=50000
declare -x MONGO_USERDB="mongodb://writer:XXXXXXX@c916.candidate.21.mongolayer.com:10916/b2"

EXPOSE 3478 3478/udp
CMD ["/bin/bash", "-c", "/usr/local/bin/turnserver -c /opt/coturn/etc/turnserver.conf"]

