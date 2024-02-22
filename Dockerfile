FROM roundcube/roundcubemail:latest

# add php-memcached extension to php:apache image
RUN apt-get update && apt-get install -y libmemcached-dev libssl-dev zlib1g-dev \
	&& pecl install memcached-3.2.0 \
	&& docker-php-ext-enable memcached
    
RUN mkdir -p /var/roundcube/config
COPY --chmod=0755 docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]