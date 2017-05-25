#!/bin/bash

# 读取两个镜像版本
labs_version=$1
echo "labs_version=$labs_version"
dind_version=$2
echo "dind_version=$dind_version"

# 拉取或更新两个镜像
docker pull hub.c.163.com/bingohuang/docker-labs:$labs_version
docker pull hub.c.163.com/bingohuang/dind:$dind_version

# 删除之前的容器
docker rm -f docker-labs
# 运行容器，注意注入环境变量
docker run -d \
--publish=80:3000 \
--volume /var/run/docker.sock:/var/run/docker.sock \
-e GOOGLE_RECAPTCHA_DISABLED="true" \
-e DIND_IMAGE="hub.c.163.com/bingohuang/dind:$dind_version"  \
-e EXPIRY="3h" \
--name docker-labs \
hub.c.163.com/bingohuang/docker-labs:$labs_version
# 查看容器时时日志
docker logs -f docker-labs
