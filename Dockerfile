from alpine: latest
run apk update && apk add apache2
cmd httpd -D FOREGROUND
