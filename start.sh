#!/bin/bash

php-fpm &

# Wait for php-fpm port 9000 to be open
until nc -z 127.0.0.1 9000; do
    sleep 0.1
done

echo "Starting Nginx..."
exec nginx -g 'daemon off;'
