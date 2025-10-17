FROM debian:bookworm

# Update package lists, upgrade installed packages, install nginx and openssl, then clean apt cache
RUN apt update -y && apt upgrade -y && \
	apt install -y nginx openssl && \
	apt clean && rm -rf /var/lib/apt/lists/*

# Copy the OpenSSL configuration file before generating the certificate
COPY ./conf/openssl.cnf /openssl.cnf

# Ensure the /etc/ssl directory exists
RUN mkdir -p /etc/ssl

# Create private and cert directories and generate a self-signed certificate using the provided OpenSSL config
RUN mkdir -p /etc/ssl/private /etc/ssl/certs && \
	openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-config /openssl.cnf

# Copy the custom Nginx configuration into the container
COPY ./conf/nginx.conf /etc/nginx/

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
