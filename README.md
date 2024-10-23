![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🏔️ Alpine - chown
![size](https://img.shields.io/docker/image-size/11notes/chown/stable?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/chown/stable?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/chown?color=2b75d6)

**chown, everything!**

# SYNOPSIS
**What can I do with this?** Well, simply put all it does is chown everything as 1000:1000 in the volume /chown. So, you can mount bind mounts or volumes and auto chown them with the correct UID/GID for docker by default. You can also easily depend other services on this, so that they only start after the volumes or bind mounts were created and have the correct permission.

It solves the issues that volumes or bind mounts can’t be set with permissions when newly created.

# VOLUMES
* **/chown** - Directory being chowned

# COMPOSE
```yaml
name: "chown"
services:
  chown:
    image: "11notes/chown:stable"
    container_name: "chown"
    environment:
      TZ: "Europe/Zurich"
    volumes:
      - source: "${PWD}/foo/bar/etc"
        target: "/chown/bar.etc"
        type: bind
        bind:
          create_host_path: true
      - source: "${PWD}/foo/bar/var"
        target: "/chown/bar.var"
        type: bind
        bind:
          create_host_path: true
  rsync:
    image: "11notes/volume-rsync:stable"
    container_name: "rsync"
    depends_on:
      chown:
        condition: service_completed_successfully
    command: ["sender"]
    environment:
      TZ: "Europe/Zurich"
      DEBUG: true
      SSH_HOSTS: |-
        10.255.255.22:22:22001
      SSH_KNOWN_HOSTS: |-
        [10.255.255.22]:22001 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5sfkgeALIpQ6GDwPp9R0K+ZsXWe3yjScK6wa/xjs1a
      SSH_PRIVATE_KEY: |-
        -----BEGIN OPENSSH PRIVATE KEY-----
        b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
        QyNTUxOQAAACCObH5IHgCyKUOhg8D6fUdCvmbF1nt8o0nCusGv8Y7NWgAAAJj74RNX++ET
        VwAAAAtzc2gtZWQyNTUxOQAAACCObH5IHgCyKUOhg8D6fUdCvmbF1nt8o0nCusGv8Y7NWg
        AAAEBbHIaHtNR4UM7eEY0K4v+6XlA7qqwMD4ejmm6ue1Y8I45sfkgeALIpQ6GDwPp9R0K+
        ZsXWe3yjScK6wa/xjs1aAAAAEXJvb3RAYjY2ODdlZWNiZjhiAQIDBA==
        -----END OPENSSH PRIVATE KEY-----
    tmpfs:
      - "/run/inotifyd:uid=1000,gid=1000"
    volumes:
      - "${PWD}/foo/bar/etc:/rsync/etc"
      - "${PWD}/foo/bar/var:/rsync/var"
    restart: "always"
```

# ENVIRONMENT
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Show debug information | |

# SOURCE
* [11notes/chown:stable](https://github.com/11notes/docker-chown/tree/stable)

# PARENT IMAGE
* [11notes/alpine:stable](https://hub.docker.com/r/11notes/alpine)

# BUILT WITH
* [alpine](https://alpinelinux.org)

# TIPS
* Use a reverse proxy like Traefik, Nginx to terminate TLS with a valid certificate
* Use Let’s Encrypt certificates to protect your SSL endpoints

# ElevenNotes<sup>™️</sup>
This image is provided to you at your own risk. Always make backups before updating an image to a new version. Check the changelog for breaking changes. You can find all my repositories on [github](https://github.com/11notes).
    