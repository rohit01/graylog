#!/usr/bin/env bash
#
# Configure minute details in graylog config using env variables with GL_CONF_
# prefix
#

set -e

source "/graylog/scripts/global.sh"

# Identify all env variables with GL_CONF_ prefix and update config
for VAR in $(env); do
    if [[ $VAR =~ ^GL_CONF_ ]]; then
        gl_conf_name=$(echo "$VAR" | sed -r 's/^GL_CONF_([^=]*)=.*/\1/' | sed 's/__/./g' | tr '[:upper:]' '[:lower:]')
        gl_conf_value=$(echo "$VAR" | sed -r "s/^[^=]*=(.*)/\1/")
        update_config "${gl_conf_name}" "${gl_conf_value}"
    fi
done
