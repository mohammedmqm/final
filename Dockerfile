FROM alpine:latest
RUN apk update && apk add apache2
CMD httpd -D FOREGROUND
