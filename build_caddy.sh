#!/bin/sh
#===============================================================================
#
#          FILE: build_caddy.sh
#
#         USAGE: ./build_caddy.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 12/12/2017 09:28
#      REVISION:  ---
#===============================================================================

cd /go/src
mkdir -p github.com/mholt
cd github.com/mholt
cd caddy
git fetch
cd ..
go get -u github.com/caddyserver/builds
cd /go/src/github.com/mholt/caddy/caddy
cp /app/plugins.go /tmp/
if [ "$1" != ""  ]; then
  /app/gen_plugins.sh $1
  echo "Enabling plugins that match: $1"
  /app/gen_plugins.sh $1
else
  ls /output/plugins.go >/dev/null 2>&1
  if [ $? = 0 ]; then
    cp /output/plugins.go /tmp/
    echo "Using your plugins.go"
  else
    echo "No plugin args, no plugins.go in volume. Giving you defaults and a editable plugins.go"
    cp /tmp/plugins.go /output/
  fi
fi


if [ "$CADDY_VERSION" = "" ]
  then
  echo "CADDY_VERSION not specified, defaulting to v0.10.10"
  CADDY_VERSION='v0.10.10'
fi
cp /tmp/plugins.go /go/src/github.com/mholt/caddy/caddy/caddymain/plugins.go
go get -u ./...
git checkout -q ${CADDY_VERSION}
go run build.go goos=linux
cp /go/src/github.com/mholt/caddy/caddy/caddy /output/caddy
