#!/bin/bash

version=":$1"
echo "version=$version"

gox -osarch="linux/amd64" \
    && docker build -t hub.c.163.com/bingohuang/docker-labs$version -f Dockerfile-build . \
    && docker push hub.c.163.com/bingohuang/docker-labs$version
