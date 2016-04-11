#!/bin/bash
cd ~

rm -f ./external_ip
rm -f ./etcd_ip

if [ -z "$ETCD_ADDRESS" ]; then
    curl http://169.254.169.254/latest/meta-data/local-ipv4 2>/dev/null > ./etcd_ip
    echo ":2379" >> ./etcd_ip
else
    echo $ETCD_ADDRESS > ./etcd_ip
fi

if [ -z "$EXTERNAL_IP" ]; then
    curl  http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null > ./external_ip
else
    echo $EXTERNAL_IP > ./external_ip
fi

export EXTERNAL_IP=`cat ./external_ip`
export ETCD_ADDRESS=`cat ./etcd_ip`

# service syslog-ng start

/usr/local/bin/turnserver -c /opt/coturn/etc/turnserver.conf


