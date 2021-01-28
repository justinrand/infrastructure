FROM nginx

LABEL co.elastic.metrics/module=nginx \
      co.elastic.metrics/metricsets=stubstatus \
      co.elastic.metrics/hosts='${data.host}:80' \
      co.elastic.metrics/period=10s

EXPOSE 80
