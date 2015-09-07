docker-coturn
=============

A Docker container running the coturn STUN/TURN server.
https://github.com/coturn/coturn

GitHub https://github.com/SteppeChange/docker-coturn

## Simple install

Create image:  
*docker build --rm --no-cache=true -t ogolosovskiy/docker-coturn ./*  
Create container and run:  
*docker run -d -t ogolosovskiy/docker-coturn*  
Check inside:  
*docker exec -it -t ogolosovskiy/docker-coturn /bin/bash*  
Check volume path:  
*docker inspect ogolosovskiy/docker-coturn*  
  
Configure:  
*/var/lib/docker/vfs/dir/_uid_volume_/etc/turnserver.conf*  
Options:  
*log-file=/opt/coturn/var/log/turn.log*  
*external-ip=52.4.244.208*  
How to check ext ip:  
*curl http://icanhazip.com*  
  
Amazon host port forwarding:  
Ports         Protocol  
30000-60000   udp  
3478          tcp    
3478          udp  

Docker restart && Enjoy !!!!

## Advanced:
  
https://github.com/coturn/coturn/blob/master/README.turnadmin  
https://github.com/coturn/coturn/blob/master/README.turnserver  
  
 1. Configure mongo TO DO   
 2. Configure WebRTC secure  
  
### WEBRTC USAGE  
  
This is a set of notes for the WebRTC users:  
  
1) WebRTC uses long-term authentication mechanism, so you have to use -a option (or --lt-cred-mech). WebRTC relaying will not work with anonymous access. With -a option, do not forget to set the default realm (-r option). You will also have to set up the user accounts, for that you have a number of options:  
    a) command-line options (-u).    
    b) a database table (SQLite or PostgreSQL or MySQL or MongoDB). You will have to set keys with turnadmin utility (see docs and wiki for turnadmin). You cannot use open passwords in the database.
    c) Redis key/value pair(s), if Redis is used. You key use either keys or open passwords with Redis; see turndb/testredisdbsetup.sh file.  
    d) You also can use the TURN REST API. You will need shared secret(s) set either through the command line option, or through the config file, or through the database table or Redis key/value pairs.  
2) Usually WebRTC uses fingerprinting (-f).  
3) -v option may be nice to see the connected clients.  
4) -X is needed if you are running your TURN server behind a NAT.  
5) --min-port and --max-port may be needed if you want to limit the relay endpoints ports number range.  

