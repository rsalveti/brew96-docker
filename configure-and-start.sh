#!/bin/bash

TZ=${TZ:-UTC}
cp "/usr/share/zoneinfo/$TZ" /etc/localtime

service nginx start
service php5-fpm start
cron

/bin/bash
