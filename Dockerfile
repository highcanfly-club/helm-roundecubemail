FROM roundcube/roundcubemail:latest-apache

RUN mkdir -p /var/roundcube/config
COPY --chmod=0755 docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]