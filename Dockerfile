FROM alpine:3

LABEL maintainer "Mark Lopez <m@silvenga.com>"

# Based on https://github.com/bokysan/docker-postfix

RUN	echo -xe \
    && apk add --no-cache --update postfix postfix-pcre ca-certificates bash

COPY files/postfix.sh /postfix.sh

VOLUME [ "/var/spool/postfix" ]

ENTRYPOINT ["/bin/bash", "/postfix.sh"]
