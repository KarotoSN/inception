
FROM debian:bookworm

# Installation de PHP-FPM, des extensions SQL, et de l'outil curl
RUN apt-get update -y && apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    curl \
    mariadb-client \
    && apt-get clean

# Téléchargement et installation de WP-CLI (WordPress en ligne de commande)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Création des dossiers nécessaires pour PHP et pour le site web
RUN mkdir -p /run/php /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

# Copie de la configuration PHP et du script de démarrage
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# Dossier de travail par défaut
WORKDIR /var/www/wordpress

EXPOSE 9000

CMD ["/usr/local/bin/init.sh"]
