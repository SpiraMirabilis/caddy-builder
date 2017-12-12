FROM golang:1.9-alpine as builder
MAINTAINER Michael Munson <michael.d.munson@gmail.com>
COPY . /app/
WORKDIR /go/src
RUN apk update \
    && apk add git && mkdir -p github.com/mholt  && mkdir -p /output/ \
    && cd github.com/mholt \
    && git clone https://github.com/mholt/caddy.git \
    && go get -u github.com/caddyserver/builds
ONBUILD COPY plugins.go /go/src/github.com/mholt/caddy/caddy/caddymain/plugins.go
ONBUILD RUN cd github.com/mholt/caddy/caddy  && git fetch && git reset origin/master \
    && go get -u ./... \
    && git checkout -q ${CADDY_VERSION} \
    && go run build.go goos=linux && cp /go/src/github.com/mholt/caddy/caddy/caddy /output/caddy
VOLUME "/output"
ENTRYPOINT "/app/build_caddy.sh"
