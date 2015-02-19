#
FROM muccg/base:debian8
MAINTAINER ccg <ccgdevops@googlegroups.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
  postfix \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./main.cf /etc/postfix/main.cf
RUN chmod 644 /etc/postfix/main.cf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 25

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postfix"]
