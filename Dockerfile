#
FROM muccg/ubuntu14.04-base:latest
MAINTAINER https://github.com/muccg

RUN apt-get update && apt-get install -y --no-install-recommends \
  postfix supervisor rsyslog \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./main.cf /etc/postfix/main.cf
RUN chmod 644 /etc/postfix/main.cf

COPY ./supervisord.conf /etc/supervisor/supervisord.conf
RUN chmod 644 /etc/supervisor/supervisord.conf

COPY ./rsyslog.conf /etc/rsyslog.conf
RUN chmod 644 /etc/rsyslog.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 25
VOLUME ["/data"]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postfix"]
