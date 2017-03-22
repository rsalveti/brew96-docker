#!/bin/sh

TZ=${TZ:-UTC}
cp "/usr/share/zoneinfo/$TZ" /etc/localtime

# Make sure permissions are all correct
/home/brewpi/utils/fixPermissions.sh

service nginx start
service php5-fpm start
cron

# Execute all the rest
exec "$@"
