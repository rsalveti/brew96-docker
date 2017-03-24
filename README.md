# brew96 - brewpi for 96boards with Sensors Mezzanine

Docker container that uses the legacy brewpi branch (arduino compatible), created to run on 96boards CE compatible platforms with the Sensors Mezzanine (arduino).

Optionally the environment variable `TZ` can be set, this will set the timezone of the docker container. If not assigned, the UTC timezone is used.

## Building the container

`$ docker build -t brew96-docker .`

### Using pre-built containers

You can also use the pre-built docker container available at https://hub.docker.com/r/rsalveti/brewpi-docker-arm64/ and https://hub.docker.com/r/rsalveti/brewpi-docker-armhf/.

ARM64 host machine:

`$ docker pull rsalveti/brewpi-docker-arm64`

ARMHF (32-bit) host machine:

`$ docker pull rsalveti/brewpi-docker-armhf`

## Flashing Arduino

BrewPi requires a specific firmware to be flashed into the Arduino chip (responsible for handling the sensor data and reporting back to the brewpi service).

To flash the BrewPi firmware into the Sensors Mezzanine Arduino chip (via a 96boards CE board):

```
$ sudo apt-get install arduino-core
$ wget https://github.com/BrewPi/firmware/releases/download/0.2.10/brewpi-arduino-uno-revC-0_2_10.hex
$ avrdude -F -e -p atmega328p -c arduino -b 115200 -P /dev/tty96B0 -U flash:w:"brewpi-arduino-uno-revC-0_2_10.hex" -C /etc/avrdude.conf
# Erase EEPROM (required after initial flash)
$ echo -ne 'E\n' > /dev/tty96B0
```

## Running BrewPi docker container

Since BrewPi writes the log, configs and data under the same folder used by the service and webui, everything is mounted as an external container volume (to allow retaining the data when updating the container image).

```
$ git clone --branch legacy --depth 1 https://github.com/BrewPi/brewpi-script ~/brewpi/home
$ git clone https://github.com/BrewPi/brewpi-www ~/brewpi/www
# Copy custom config, required for the UART/arduino port
$ cp brewpi-config.cfg ~/brewpi/home/settings/config.cfg
```

Then just start with docker run:

`$ docker run -it -p 8080:80 -v ~/brewpi/home:/home/brewpi -v ~/brewpi/www:/var/www --device=/dev/ttyMSM1 brew96-docker bash`

## Additional info

BrewPi Shield (pin mapping used by the Arduino firmware):

- Pin Mapping: http://www.brewpi.com/wp-content/uploads/2012/12/BrewPi-Shield-Pin-Mapping4.png
- Schematic: http://www.brewpi.com/wp-content/uploads/2012/12/brewpi_shield_schematic10-1024x929.png
