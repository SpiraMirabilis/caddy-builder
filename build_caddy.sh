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

ls /output/plugins.go >/dev/null 2>&1
if [ $? = 0 ]; then
   echo "Using your plugins.go"
else
  echo "No plugins.go file found in the output folder, using a default one -- I'll include this with the caddy bin in case you want to edit it"
  cp /app/plugins.go /output/plugins.go
fi
if [ "$CADDY_VERSION" = "" ]
then
  echo "CADDY_VERSION not specified, defaulting to v0.10.10"
  CADDY_VERSION='v0.10.10'
fi
cd /go/src
mkdir -p github.com/mholt
cd github.com/mholt
git clone https://github.com/mholt/caddy.git
go get -u github.com/caddyserver/builds
cp /output/plugins.go /go/src/github.com/mholt/caddy/caddy/caddymain/plugins.go
cd /go/src/github.com/mholt/caddy/caddy
go get -u ./...
git checkout -q ${CADDY_VERSION}
go run build.go goos=linux
cp /go/src/github.com/mholt/caddy/caddy/caddy /output/caddy
