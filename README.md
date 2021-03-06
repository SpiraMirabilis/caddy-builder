# caddy builder


This is a image that builds a version of caddy on demand. It can also be used as a base image in multi-stage builds and or if you want to have custom plugins in your caddy server

Use either as a build container, when run it checks /output/ volume for a plugins.go -- if not found it will copy a default into there (which includes every plugin commented out.) If you want your build to have plugins you should ctrl+c, edit the plugins.go to uncomment desirable plugins and then re-run. After build is complete it will copy the caddy binary to /output/ volume and bob's your uncle.

>$ docker run --rm -v $(pwd):/output/ caddy-builder  

To give a list of plugins without having to create your own plugins.go file, send a comma delimeted list of plugins:


>$ docker run --rm -v $(pwd):/output/ caddy-builder cors,dnsproviders\/azure,hugo

All this does is loop through the sample plugins.go and uncomment any line that matches each word, but it works for now.

This image can also be used a template for multistage Docker builds, in that case you should create a directory with a `Dockerfile` and a `plugins.go` file where you must code the plugin paths of your plugins you want to have in your caddy server. A simple example is below:

>FROM SpiraMirabilis/caddy-builder as builder  
>FROM php:7.2.0-fpm-alpine3.6  
>ONBUILD COPY --from=builder /output/caddy /usr/bin/  
>ONBUILD RUN setcap cap_net_bind_service=+ep /usr/bin/caddy  
>EXPOSE 80 443 2015  
>ENTRYPOINT ["/usr/bin/caddy"]  
>CMD ["--conf", "/conf/Caddyfile"]  
