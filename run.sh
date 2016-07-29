#!/usr/bin/env bash
#
# Startup script - graylog-server
# Author: Rohit Gupta - @rohit01
#

set -e

source /graylog/scripts/configure_linked_containers.sh
source /graylog/scripts/easy_configuration.sh
source /graylog/scripts/advanced_configuration.sh

source /etc/default/graylog-server
source /usr/share/graylog-server/installation-source.sh

# Run Graylog
exec $GRAYLOG_COMMAND_WRAPPER ${JAVA:=/usr/bin/java} $GRAYLOG_SERVER_JAVA_OPTS \
        -jar -Dlog4j.configurationFile=file:///etc/graylog/server/log4j2.xml \
        -Djava.library.path=/usr/share/graylog-server/lib/sigar \
        -Dgraylog2.installation_source=${GRAYLOG_INSTALLATION_SOURCE:=unknown} \
        /usr/share/graylog-server/graylog.jar server -f /etc/graylog/server/server.conf -np \
        $GRAYLOG_SERVER_ARGS
