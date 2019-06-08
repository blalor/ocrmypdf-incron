FROM jbarlow83/ocrmypdf-alpine:v8.2.3

## bash because arrays
## tini because docker-compose on qnap doesn't yet support `init: true`
RUN apk add incron bash tini
ADD incrontab /etc/incron.d/ocrmypdf
ADD process.sh /process.sh
RUN chmod 555 /process.sh

# ENTRYPOINT ["/usr/sbin/incrond", "--foreground"]
# CMD ["--config=/etc/incron.conf"]

ENTRYPOINT ["/sbin/tini", "-vv", "-w"]
CMD ["/usr/sbin/incrond", "--foreground", "--config=/etc/incron.conf"]
