# Based on debian jessie (8)
FROM java:8
MAINTAINER Rohit Gupta <hello@rohit.io>

ENV     GRAYLOG_REPO_DEB="https://packages.graylog2.org/repo/debian/pool/stable/2.0/g/graylog-2.0-repository/graylog-2.0-repository_1-1_all.deb"

RUN     apt-get update \
            && apt-get -y upgrade \
            && apt-get install -y --no-install-recommends wget \
                apt-transport-https \
            && wget -O "/tmp/graylog-repo.deb" "${GRAYLOG_REPO_DEB}" \
            && dpkg -i "/tmp/graylog-repo.deb" \
            && apt-get update \
            && apt-get install -y graylog-server \
            && mkdir -p /graylog \
            && rm "/tmp/graylog-repo.deb"

COPY    log4j2.xml /etc/graylog/server/log4j2.xml

# Copy startup script
COPY    run.sh /graylog/run.sh

# Execute
WORKDIR /graylog
CMD     exec /graylog/run.sh

