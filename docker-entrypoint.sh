#!/bin/bash

echo "HOME is ${HOME}"
echo "WHOAMI is `whoami`"

# any failures below here are considered fatal
set -e

mkdir -p /data/queue
cp -a /etc/hosts /data/queue/etc/hosts
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf

