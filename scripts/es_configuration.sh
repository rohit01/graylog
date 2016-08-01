#!/usr/bin/env bash
#
# Configure elasticsearch based on info from server.conf
#

set -e

source "/graylog/scripts/global.sh"

es_config_path="$(get_config elasticsearch_config_file)"
if [ "X${es_config_path}" == "X" ]; then
    es_config_path="/etc/graylog/server/elasticsearch.yml"
    update_config "elasticsearch_config_file" "/etc/graylog/server/elasticsearch.yml"
fi

es_dir_path="$(dirname ${es_config_path})"
if [ ! -d "${es_dir_path}" ]; then
    mkdir -p "${es_dir_path}"
fi

if [ ! -f "${es_config_path}" ]; then
    echo "cluster.name: $(get_config elasticsearch_cluster_name)" > "${es_config_path}"
    echo "node.master: false" >> "${es_config_path}"
    echo "node.data: false" >> "${es_config_path}"
    echo "transport.tcp.port: 9350" >> "${es_config_path}"
    echo "http.enabled: false" >> "${es_config_path}"
    echo "discovery.zen.ping.multicast.enabled: false" >> "${es_config_path}"
    echo "discovery.zen.ping.unicast.hosts: $(get_config elasticsearch_discovery_zen_ping_unicast_hosts)" >> "${es_config_path}"
fi
