#!/bin/sh
set -eu
# Cron could be run from a separate container
# Set `NO_CRON` to disable here
if [[ -z "${NO_CRON+true}" ]]; then
  crond -b -d 9
fi

exec "$@"
