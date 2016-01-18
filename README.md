# brewpi
Docker container to run brewpi-script and brewpi-www

To use this container set an environment variable `AVR` which should be the address and port of the arduino/esp8266 e.g `192.168.0.25:23`
The port will be written to settings/config.cfg and prefixed with socket://
The final config.cfg file should look like:

```
port = socket://192.168.0.25:23
altport = socket://192.168.0.25:23
```

The brewpi-script is using the legacy branch, this is because I am using an Arduino and esp8266 (despite the brewpi spark looking completely awesome!).

Hosted on Docker Hub: https://hub.docker.com/r/seeflat/brewpi/
