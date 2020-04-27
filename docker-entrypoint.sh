#!/usr/bin/env sh

set -e

/build/docache.sh &

ln -sf /build/node_modules .

exec "$@"
