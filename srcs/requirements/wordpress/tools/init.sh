#!/bin/bash

# On vérifie si WordPress est déjà installé (pour ne pas tout écraser si le conteneur redémarre)
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Installation de WordPress..."

    # 1. Téléchargement des fichiers sources de WordPress
    wp core download --allow-root

    # 2. Création du fichier wp-config.php pour lier WordPress à notre conteneur MariaDB
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb:3306" \
        --allow-root

    # 3. Installation de base et création de l'administrateur
    # Attention : Le sujet interdit formellement que l'admin s'appelle 'admin' ou 'Admin'
    wp core install \
        --url="aarab.42.fr" \
        --title="Mon super site Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    # 4. Création du 2ème utilisateur (non-administrateur) exigé par le sujet
    wp user create \
        "${WP_USER_LOGIN}" \
        "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=author \
        --allow-root
        
    echo "WordPress est configuré avec succès !"
fi

# Lancement de PHP-FPM au premier plan (le PID 1 du conteneur)
exec /usr/sbin/php-fpm8.2 -F
