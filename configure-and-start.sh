#!/bin/bash

AVR=${AVR:-brewpi.arduino.local:23}
sed -i.bak "s#^port.*#port = socket://$AVR#" /home/brewpi/settings/config.cfg
sed -i.bak "s#^altport.*#altport = socket://$AVR#" /home/brewpi/settings/config.cfg

service nginx start
service php5-fpm start
cron

/bin/bash
