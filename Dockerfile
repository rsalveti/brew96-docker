FROM vicamo/debian:jessie-arm64
MAINTAINER Ricardo Salveti <rsalveti@rsalveti.net>
#Steps to follow are here: http://docs.brewpi.com/manual-brewpi-install/manual-brewpi-install.html

EXPOSE 80

# Basic debian dependencies
RUN apt-get update && apt-get -y install git python python-dev python-pip cron sudo

# Install and configure lemp server
RUN apt-get -y install nginx php5 php5-fpm
RUN rm -rf /var/www/*
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
COPY nginx-config /etc/nginx/sites-available/default

# Install python requirements
RUN pip install pyserial simplejson configobj psutil gitpython

# Additional dependencies
RUN apt-get -y install arduino-core

# Set up users and permission
RUN useradd -m -k /dev/null -G www-data,dialout brewpi
RUN echo 'brewpi:brewpi' | chpasswd
RUN chown -R www-data:www-data /var/www
RUN chown -R brewpi:brewpi /home/brewpi

# Run BrewPi code & data from external volume (persist data)
VOLUME ["/home/brewpi", "/var/www"]

# Set up BrewPi config files
COPY brewpi-crontab /etc/cron.d/brewpi
RUN chmod 0644 /etc/cron.d/brewpi

# Start the cron daemon shell
COPY configure-and-start.sh configure-and-start.sh
RUN chmod +x configure-and-start.sh
ENTRYPOINT ["/configure-and-start.sh"]

# Default to simply dump the brewpi logs
CMD tail -f /home/brewpi/logs/*
