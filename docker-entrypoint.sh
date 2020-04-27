#!/usr/bin/env sh

set -e

./docache.sh &

ln -sf /build/node_modules .

exec "$@"
