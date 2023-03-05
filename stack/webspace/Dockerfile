FROM debian:10-slim

ENV DEBIAN_FRONTEND noninteractive
ENV TIMEZONE Europe/Madrid

# Configure service timezone
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    echo $TIMEZONE > /etc/timezone

# Install dependencies
RUN apt update && apt install -y \
      apache2 apache2-utils apache2-bin

## For localhost testing pruposes, uncomment in localhost
RUN apt-get install -y openssl
RUN mkdir -p /etc/ssl/certs; \
    openssl req -x509 -newkey rsa:4096 \
    -subj "/C=ES/ST=SPAIN/L=BARCELONA/O=VIDNEO/CN=localhost" \
    -keyout "/etc/ssl/certs/key.pem" \
    -out "/etc/ssl/certs/cert.pem" \
    -days 365 -nodes -sha256

# Configure apache
RUN a2enmod ssl rewrite headers proxy proxy_http
ADD etc/apache2/.htpasswd /etc/apache2/.htpasswd
ADD etc/apache2/conf.d/security /etc/apache2/conf.d/security
ADD etc/apache2/mods-available/mpm-prefork.conf /etc/apache2/mods-available/mpm-prefork.conf
ADD etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

# Expose HTTPS port
EXPOSE 443

# Enable startup script
ADD bin/startup.sh /usr/src/startup.sh
RUN chmod +x /usr/src/startup.sh
ENTRYPOINT /usr/src/startup.sh
