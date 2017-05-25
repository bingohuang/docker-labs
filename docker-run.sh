#!/bin/bash

labs_version=$1
echo "labs_version=$labs_version"

dind_version=$2
echo "dind_version=$dind_version"

docker pull hub.c.163.com/bingohuang/docker-labs:$labs_version
docker pull hub.c.163.com/bingohuang/dind:$dind_version

docker rm -f docker-labs
docker run -d \
--publish=80:3000 \
--volume /var/run/docker.sock:/var/run/docker.sock \
-e GOOGLE_RECAPTCHA_DISABLED="true" \
-e DIND_IMAGE="hub.c.163.com/bingohuang/dind:$dind_version"  \
-e EXPIRY="3h" \
--name docker-labs \
hub.c.163.com/bingohuang/docker-labs:$labs_version
