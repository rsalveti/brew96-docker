#!/bin/bash

AVR=${AVR:-brewpi.arduino.local:23}
sed -i.bak "s#^port.*#port = socket://$AVR#" /home/brewpi/settings/config.cfg
sed -i.bak "s#^altport.*#altport = socket://$AVR#" /home/brewpi/settings/config.cfg

TZ=${TZ:-UTC}
cp "/usr/share/zoneinfo/$TZ" /etc/localtime

service nginx start
service php5-fpm start
cron

/bin/bash
