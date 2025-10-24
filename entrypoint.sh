#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status. This prevents
# unexpected errors from causing cascading failures.
set -e

# --- Fix WordPress Permissions ---
# On every container start, recursively set the ownership of the entire
# /var/www/html/wp-content directory to the 'www-data' user and group.
# This is crucial because files mounted from the host may have the wrong owner
# from the container's perspective. Correct ownership is required for WordPress
# to manage media uploads, as well as install or update plugins and themes.
chown -R www-data:www-data /var/www/html/wp-content

# --- Hand Off to the Original Entrypoint ---
# After our custom setup is complete, use 'exec' to run the official entrypoint
# script from the base WordPress image ('docker-entrypoint.sh').
#
# 'exec' replaces this script's process with the new one, making it the main
# process of the container. This is more efficient and ensures signals are
# handled correctly.
#
# '"$@"' passes along all the original arguments that this script received
# (like "apache2-foreground" from the Dockerfile's CMD).
exec docker-entrypoint.sh "$@"