#!/bin/sh
set -eo pipefail

if [ $# -gt 0 ]; then
    exec $@
else
    trap 'kill $(jobs -p) && wait' TERM INT
    hdfs namenode &
    if [ "$YARN_START" = true ]; then
        yarn resourcemanager &
        yarn nodemanager &
    fi
    hdfs datanode &
    wait
fi
