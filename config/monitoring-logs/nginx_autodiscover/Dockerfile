FROM nginx
COPY /html /usr/share/nginx/html
LABEL co.elastic.logs/module=nginx \
      co.elastic.logs/fileset.stdout=access \
      co.elastic.logs/fileset.stderr=error

EXPOSE 80
