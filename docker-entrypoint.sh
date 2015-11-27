#!/bin/bash

function defaults {
    : ${MYHOSTNAME:="$HOSTNAME"}
    : ${MAILNAME:="$HOSTNAME"}
    export MYHOSTNAME
}

defaults

echo "HOME is ${HOME}"
echo "WHOAMI is `whoami`"

# any failures below here are considered fatal
set -e

qdir=/data/queue
mkdir -p "$qdir"/etc
FILES="etc/localtime etc/services etc/resolv.conf etc/hosts \
    etc/host.conf etc/nsswitch.conf"
for file in $FILES; do
    cp -a /"$file" "$qdir"/"$file"
done

sed -i "s/@MAILNAME@/$MAILNAME/g" /etc/postfix/main.cf
sed -i "s/@MYHOSTNAME@/$MYHOSTNAME/g" /etc/postfix/main.cf

cat /etc/postfix/main.cf

if [ "$1" = 'postfix' ]; then
    exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
fi

echo "[RUN]: Builtin command not provided [postfix]"
echo "[RUN]: $@"

exec "$@"
