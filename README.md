# docker-conman

A docker container to run [dun/conmain](https://github.com/dun/conman).

# Usage

### docker-compose

Compatible with docker-compose

```
---
services:
  conman:
    image: jchonig/conman
    container_name: conman
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    privileged: true	# When mounting /dev
    volumes:
	  - PATHTO/config:/config
	  - PATHTO/logs:/logs
      - /dev:/dev		# Optional
      - /run/udev:/run/udev:ro # Optional
	expose:
	  - 7980
    devices:
      - /dev/ttyUSB00:/dev/ttyUSB00
    restart: unless-stopped
```


# Parameters

## Environment Variables (-e)

| Env       | Function                                      |
| ---       | --------                                      |
| PUID=1000 | for UserID - Set to UID that will run conman  |
| PGID=1000 | for GroupID - Set to GID that will run conman |
| TZ=UTC    | Specify a timezone to use EG UTC              |

## Volume Mappings (-v)

| Volume    | Function                                                             |
|-----------|----------------------------------------------------------------------|
| /config   | This directory will contain conman.conf                              |
| /logs     | This directory is for storing logfiles                               |
| /dev      | For direct access to device entries (if they don't exist at startup) |
| /run/udev | ""                                                                      |

# Application Setup

  + If /config/conman.conf does not exist, the default configuration
    file will be installed
  + Map any serial devices into the container or mount /dev into the container

# TODO
  + [ ] Pass logrotate parameters as ENV variables?
