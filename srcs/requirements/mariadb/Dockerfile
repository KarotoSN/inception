

FROM debian:bookworm

#Installation de MariaDB
RUN apt-get update -y && apt-get install -y mariadb-server && apt-get clean

# Copie de la configuration réseau
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copie du script d'initialisation et attribution des droits d'exécution
COPY tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

EXPOSE 3306

# Le script sera notre point d'entrée
CMD ["/usr/local/bin/init.sh"]
