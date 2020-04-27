# node-caching

Please be aware this software is alpha quality right now.

This repository generates node docker images that persist the yarn cache and
keeps node_modules inside the container. Its designed to be used as a
development shell, with your app mounted under `/app/`. It uses the entrypoint
and a backup script to persist the yarn cache to `.yarn_cache` on each run,
which is fed back into `docker build` so yarn doesn't need to redownload
everything on each update.

## Building

``` sh
# build images for every installed docker node tag
./build.sh

# build a specific node tag
./build.sh 10
./build.sh 12-alpine
```

## Usage

This image only works as a base for other images. It uses the entrypoint to
perform the caching so don't override it unless you know what you're doing:

``` Dockerfile
FROM neonfuz/node-caching:12-alpine
EXPOSE 8000
CMD [ "yarn", "start" ]
```

The caching also expects your app to be mounted to /app, so use `-v $PWD:/app`
when running:

``` sh
# Initialize .yarn cache with an empty tarball
tar cf - --files-from /dev/null > .yarn_cache
# Build your app
docker build . -t neonfuz/someapp
# Run app mounted to /app
docker run --rm -it -v $PWD:/app neonfuz/someapp
```

The entrypoint calls `/build/docache.sh` which persists the yarn cache for
future builds.

## Adding / updating packages

To add or update packages, attach to your running container and use yarn like
you normally do. When you're done call `/build/docache.sh` to persist the cache
for next build. If you forget to do this the changes will need to be
redownloaded on the next `docker build` call.

``` sh
# get name of running container
docker ps

# run shell on running container 
docker exec -ti container_name sh

# add, update packages, etc
yarn add somepackage
yarn upgrade

# persist packages for next build
/build/docache.sh
```
