#!/bin/bash

echo "HOME is ${HOME}"
echo "WHOAMI is `whoami`"

# any failures below here are considered fatal
set -e

if [ "$1" = 'postfix' ]; then
    echo "[Run] Starting postfix"
    /usr/sbin/postfix start
    while /bin/true; do
        postfix status 2>&1 >/dev/null || (
            echo "Postfix has exited; shutting down container!"
        )
        sleep 60
    done
fi

exec "$@"
