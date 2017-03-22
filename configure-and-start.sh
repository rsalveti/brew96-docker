#!/bin/sh

TZ=${TZ:-UTC}
cp "/usr/share/zoneinfo/$TZ" /etc/localtime

# Make sure permissions are all correct
/home/brewpi/utils/fixPermissions.sh

service nginx start
service php5-fpm start
cron

# Workaround https://github.com/docker/docker/issues/16813
touch /etc/crontab
touch /etc/cron.d/*

# Execute all the rest
exec "$@"
