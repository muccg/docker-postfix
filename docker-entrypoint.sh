#!/bin/bash

echo "HOME is ${HOME}"
echo "WHOAMI is `whoami`"

# any failures below here are considered fatal
set -e

qdir=/data/queue
mkdir -p /data/queue
[ -f /data/queue/etc/hosts ] && cp -a /etc/hosts /data/queue/etc/hosts
[ -f /data/queue/etc/services ] && cp -f /etc/services /data/queue/etc/services

mkdir -p "$qdir"/etc
FILES="etc/localtime etc/services etc/resolv.conf etc/hosts \
    etc/host.conf etc/nsswitch.conf"
for file in $FILES; do
    cp -a /"$file" "$qdir"/"$file"
done


sleep 5

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf

