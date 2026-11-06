#!/bin/bash

# Création du dossier pour le processus (socket) de MariaDB
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialisation de la base de données système si elle n'existe pas encore
if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null
fi

# Création d'un fichier SQL temporaire avec tes variables d'environnement
cat << EOF > /tmp/create_db.sql
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Lancement de MariaDB en premier plan avec notre fichier SQL
exec mysqld --user=mysql --init-file=/tmp/create_db.sql
