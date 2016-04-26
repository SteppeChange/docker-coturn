#!/bin/bash
cd ~

rm -f ./external_ip
rm -f ./etcd_ip
rm -f ./etcd_val

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

echo external ip $EXTERNAL_IP
echo etcd url $ETCD_ADDRESS

#export ETCD_ADDRESS=172.30.1.152:2379

curl -L "http://$ETCD_ADDRESS/v2/keys/config/bws/server/call_secret" | grep -Po '"value":.*?[^\\]",' > etcd_val
export ETCD_VAL=`cat ./etcd_val`
echo ${ETCD_VAL:9:-2} > etcd_key
export SECRET_KEY=`cat ./etcd_key`

echo key $SECRET_KEY | sed 's/[0-9]*/X/g'

if [ -z "$SECRET_KEY" ]; then
  echo "ERROR: \$SECRET_KEY is wrong" 
  exit 1
fi

# service syslog-ng start

/usr/local/bin/turnserver -c /opt/coturn/etc/turnserver.conf

