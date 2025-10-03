

FROM nginx:alpine

# Install openssl for certificate generation
RUN apk add --no-cache openssl

# Copier le fichier de configuration avant de générer le certificat
COPY ./openssl.cnf /openssl.cnf

# Generate self-signed certificate
RUN mkdir -p /etc/ssl/private && \
	openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-config /openssl.cnf

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf

