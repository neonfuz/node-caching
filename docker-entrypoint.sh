#!/usr/bin/env sh

set -e

# tar cache, compare to mounted .yarn_cache
docache() {
    tar -czf - /usr/local/share/.cache/yarn > /build/.yarn_cache
    if [ "$(crc32 /build/.yarn_cache)" != "$(crc32 /app/.yarn_cache)" ]; then
        cp /build/.yarn_cache .yarn_cache
    fi
}

docache &

ln -sf /build/node_modules .

exec "$@"
