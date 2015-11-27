#!/bin/sh
#
# Script to build images
#

# break on error
set -e

REPO="muccg"
DATE=`date +%Y.%m.%d`

DOCKER_HOST=$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
HTTP_PROXY="http://${DOCKER_HOST}:3128"

: ${DOCKER_BUILD_OPTIONS:="--pull=true --build-arg HTTP_PROXY=${HTTP_PROXY} --build-arg http_proxy=${HTTP_PROXY}"}

image="${REPO}/postfix"
echo "################################################################### ${image}"
        
## warm up cache for CI
docker pull ${image} || true

for tag in "${image}:latest" "${image}:latest-${DATE}"; do
    echo "############################################################# ${tag}"
    set -x
    docker build ${DOCKER_BUILD_OPTIONS} -t ${tag} .
    docker inspect ${tag}
    docker push ${tag}
    set +x
done
