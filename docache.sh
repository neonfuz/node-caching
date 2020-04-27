#!/usr/bin/env sh

set -e

prefix="yarn cache: "

echo ${prefix}Backing up yarn cache... 1>&2
tar -czf - /usr/local/share/.cache/yarn > /build/.yarn_cache 2>/dev/null
if ! diff -q /build/.yarn_cache /app/.yarn_cache; then
    echo ${prefix}Changes detected, updating .yarn_cache 1>&2
    cp /build/.yarn_cache /app/.yarn_cache
fi
echo ${prefix}Backup done 1>&2
