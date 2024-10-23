# :: Util
FROM alpine as util

RUN set -ex; \
  apk add --no-cache \
    git; \
  git clone https://github.com/11notes/util.git;

# :: Header
FROM 11notes/alpine:stable
COPY --from=util /util/linux/shell/elevenLogJSON /usr/local/bin
ENV APP_VERSION=stable
ENV APP_NAME="chown"
ENV APP_ROOT=/chown

# :: Run
USER root

# :: install application
RUN set -ex; \
  mkdir -p ${APP_ROOT}; \
  apk --no-cache upgrade;

# :: copy root filesystem changes and add execution rights to init scripts
COPY ./rootfs /
RUN set -ex; \
  chmod +x -R /usr/local/bin

# :: change home path for existing user and set correct permission
RUN set -ex; \
  usermod -d ${APP_ROOT} docker; \
  chown -R 1000:1000 \
    ${APP_ROOT};

# :: Volumes
VOLUME ["${APP_ROOT}"]

# :: Start
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]