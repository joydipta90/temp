#!/bin/bash
# Start PHP-FPM in the background
php-fpm &

# Wait for PHP-FPM to be ready
until curl --silent --head --fail http://127.0.0.1:9000 > /dev/null; do
    sleep 0.1
done

# Start Nginx in the foreground
exec nginx -g 'daemon off;'
