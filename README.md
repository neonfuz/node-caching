# node-caching

Please be aware this software is alpha quality right now.

This repository generates node docker images that persists the yarn cache to
save bandwidth and time. To use make sure you have pulled the version of node
you wish to use, then run `./build.sh` to generate caching versions of every
node image installed. Then in your project create a Dockerfile with FROM set to
the generated image. Delete node_modules from your project if it exists, and
bootstrap the yarn cache with an empty tarball with
`tar cf - --files-from /dev/null > .yarn_cache`. Then build your apps docker
image like normal. On first run the yarn cache will be backed up for next build.
