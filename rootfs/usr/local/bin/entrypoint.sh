#!/bin/ash
  elevenLogJSON info "chown -R 1000:1000 ${APP_ROOT}"
  chown -R 1000:1000 ${APP_ROOT}
  exit 0