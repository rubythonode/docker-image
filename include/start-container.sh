#!/bin/bash
# Copyright 2017 Yahoo Holdings. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.

set -e

if [ $# -gt 1 ]; then
    echo "Allowed arguments to entrypoint are {configserver,services}."
    exit 1
fi

# Always set the hostname to the FQDN name if available
hostname $(hostname -f) || true

# Always make sure vespa:vespa owns what is in /opt/vespa
chown -R vespa:vespa /opt/vespa

if [ -n "$1" ]; then
    if [ -z "$VESPA_CONFIGSERVERS" ]; then
        echo "VESPA_CONFIGSERVERS must be set with '-e VESPA_CONFIGSERVERS=<comma separated list of config servers>' argument to docker."
        exit 1
    fi
    case $1 in
        configserver)
            /opt/vespa/bin/vespa-start-configserver
            /opt/vespa/bin/vespa-start-services
            ;;
        services)
            /opt/vespa/bin/vespa-start-services
            ;;
        *)
            echo "Allowed arguments to entrypoint are {configserver,services}."
            exit 1
            ;;
    esac
else
    export VESPA_CONFIG_SERVERS=$(hostname)
    /opt/vespa/bin/vespa-start-configserver
    /opt/vespa/bin/vespa-start-services
fi

tail -f /dev/null
