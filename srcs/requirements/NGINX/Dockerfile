FROM debian:bookworm

# Install openssl for certificate generation
RUN apt update -y && apt upgrade -y && \
    apt install -y nginx openssl && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Copier le fichier de configuration avant de générer le certificat
COPY ./tools/openssl.cnf /openssl.cnf

RUN mkdir -p /etc/ssl

# Generate self-signed certificate
RUN mkdir -p /etc/ssl/private /etc/ssl/certs && \
	openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-config /openssl.cnf

COPY ./tools/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
