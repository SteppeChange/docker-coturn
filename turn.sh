#!/bin/bash
cd ~
rm -f ./external_ip

if [ -z "$EXTERNAL_IP" ]; then
    curl  http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null > ./external_ip
else
    echo $EXTERNAL_IP > ./external_ip
fi

export EXTERNAL_IP=`cat ./external_ip`

service syslog-ng start

/usr/local/bin/turnserver -c /opt/coturn/etc/turnserver.conf


