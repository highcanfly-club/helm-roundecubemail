FROM roundcube/roundcubemail:latest as builder
# add php-memcached extension to php:apache image

RUN apt-get update && apt-get install -y libmemcached-dev libssl-dev zlib1g-dev \
	&& pecl install memcached-3.2.0 \
	&& docker-php-ext-enable memcached

FROM roundcube/roundcubemail:latest
RUN apt-get update && apt-get install -y libmemcached11
COPY --from=builder /usr/local/lib/php/extensions/no-debug-non-zts-20210902/memcached.so /usr/local/lib/php/extensions/no-debug-non-zts-20210902/memcached.so
COPY --from=builder /usr/local/etc/php/conf.d/docker-php-ext-memcached.ini /usr/local/etc/php/conf.d/docker-php-ext-memcached.ini
RUN mkdir -p /var/roundcube/config
COPY --chmod=0755 docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]