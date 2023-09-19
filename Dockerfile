FROM roundcube/roundcubemail:latest-fpm-alpine

RUN mkdir -p /var/roundcube/config
COPY --chmod=0755 docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["php-fpm"]