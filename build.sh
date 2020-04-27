#!/usr/bin/env bash

TAG_PREFIX=neonfuz/

if [[ "$#" -ne 0 ]]
then tags=$@
else tags=$(docker images node | tail -n +2 | awk '{print $2}')
fi

for tag in $tags; do
    docker build . -f - -t ${TAG_PREFIX}node-caching:$tag <<EOF
        FROM node:$tag
        WORKDIR /build/
        COPY docker-entrypoint.sh docache.sh ./
        ONBUILD COPY package.json yarn.lock ./
        ONBUILD ADD .yarn_cache /
        ONBUILD RUN yarn
        ONBUILD WORKDIR /app
        ONBUILD ENTRYPOINT [ "/build/docker-entrypoint.sh" ]
EOF
done
