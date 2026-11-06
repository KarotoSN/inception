

FROM debian:bookworm

# Mise à jour et installation des paquets
RUN apt update && apt install -y nginx openssl

# Création du dossier pour le certificat et génération du certificat auto-signé
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=aarab.42.fr/UID=aarab"

# Création du dossier nécessaire à NGINX pour ses fichiers d'exécution
RUN mkdir -p /var/run/nginx

# Copie de notre fichier de configuration personnalisé
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Le conteneur écoutera sur le port 443
EXPOSE 443

# Lancement de NGINX en premier plan
CMD [ "nginx", "-g", "daemon off;" ]
