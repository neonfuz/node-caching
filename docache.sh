#!/usr/bin/env sh

tar -czf - /usr/local/share/.cache/yarn > /build/.yarn_cache
if [ diff /build/.yarn_cache /app/.yarn_cache ]; then
    cp /build/.yarn_cache /app/.yarn_cache
fi
