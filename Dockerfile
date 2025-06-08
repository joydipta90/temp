FROM php:8.3-fpm

# Install Nginx
RUN apt-get update && \
    apt-get install -y nginx netcat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
COPY . .

# PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Nginx config
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost/ || exit 1

# Startup script
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 80

CMD ["start.sh"]