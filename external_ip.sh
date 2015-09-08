#!/bin/sh
cd ~
if [ ! -f "./external_ip" ]; then
  if [ -z "$EXTERNAL_IP" ]; then
      curl http://icanhazip.com 2>/dev/null > ./external_ip
  else
      echo $EXTERNAL_IP > ./external_ip
  fi
fi

echo "export EXTERNAL_IP=`cat ./external_ip`" >> ./.bashrc
