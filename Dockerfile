#
FROM python:2.7-slim
MAINTAINER https://github.com/muccg/

RUN apt-get update && apt-get install -y --no-install-recommends \
  postfix \
  rsyslog \
  supervisor \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY etc /etc
RUN chmod 644 /etc/postfix/main.cf
RUN chmod 644 /etc/supervisor/supervisord.conf
RUN chmod 644 /etc/rsyslog.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 25
VOLUME ["/data"]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postfix"]
