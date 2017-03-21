FROM alpine

ENV CONFD_VERSION=0.12.0-alpha3

RUN apk add --no-cache curl \
  && curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 \
  && chmod +x /usr/local/bin/confd \
  && mkdir -p /postgres-c2c-conf/docker-entrypoint-initdb.d

COPY ./conf.d/ /etc/confd/conf.d/
COPY ./templates/ /etc/confd/templates/

VOLUME [ "/etc/alertmanager" ]

ENTRYPOINT ["confd"]
CMD ["-onetime", "-backend", "env"]

