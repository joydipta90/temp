#!/bin/bash
set -ex  # show each command + stop on error

echo "Starting PHP-FPM..."
php-fpm &

# Optional wait - not strictly needed
sleep 1

echo "Starting Nginx..."
exec nginx -g 'daemon off;'
