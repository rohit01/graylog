#!/usr/bin/env bash
#
# Auto-configure graylog config if mongodb and elasticsearch docker containers
# are linked
#

set -e

source "/graylog/scripts/global.sh"

if [ ! -z "${MONGO_PORT_27017_TCP_ADDR}" ] && [ ! -z "${MONGO_PORT_27017_TCP_PORT}" ]; then
    sed -i -e "s\mongodb_uri =.*$\mongodb_uri = mongodb://${MONGO_PORT_27017_TCP_ADDR}:${MONGO_PORT_27017_TCP_PORT}/graylog\\" $CONFIG_FILE
fi

if [ ! -z "${ELASTICSEARCH_PORT_9300_TCP_ADDR}" ] && [ ! -z "${ELASTICSEARCH_PORT_9300_TCP_PORT}" ]; then
    sed -i -e "s\#elasticsearch_discovery_zen_ping_unicast_hosts =.*$\#elasticsearch_discovery_zen_ping_unicast_hosts =${ELASTICSEARCH_PORT_9300_TCP_ADDR}:${ELASTICSEARCH_PORT_9300_TCP_PORT}\\" $CONFIG_FILE
fi
