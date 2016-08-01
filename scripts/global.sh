#!/usr/bin/env bash
#
# Global variable and functions for scripts
#

set -e

CONFIG_FILE="/etc/graylog/server/server.conf"
INIT_CONFIG_FILE="/etc/default/graylog-server"
ELASTICSEARCH_YML_FILE="/etc/graylog/server/elasticsearch.yml"

update_config() {
    ckey="${1}"
    cvalue="${2}"
    if grep "^\s*${ckey}\s*=.*$" ${CONFIG_FILE} >/dev/null; then
        sed -i -e "s|^\s*${ckey}\s*=.*$|${ckey} = ${cvalue}|" ${CONFIG_FILE}
    elif grep "^\s*#\s*${ckey}\s*=.*$" ${CONFIG_FILE} >/dev/null; then
        sed -i -e "0,/^\s*#\s*${ckey}\s*=.*$/s||${ckey} = ${cvalue}|" ${CONFIG_FILE}
    else
        echo "${ckey} = ${cvalue}" >> ${CONFIG_FILE}
    fi
}

get_config() {
    # echo the value of config if it is defined
    ckey="${1}"
    grep "^\s*${ckey}\s*=.*$" ${CONFIG_FILE} | sed -e "s|^\s*${ckey}\s*=\(.*\)$|\1|" -e "s|^\s*||" -e "s|\s*$||"
}
