# Use the latest official WordPress image as the starting point for our build.
FROM wordpress:latest

# Change the web server user's (www-data) UID and GID to 1000 to match the host user.
# This prevents file permission issues when using mounted volumes.
RUN groupmod -g 1000 www-data && \
    usermod -u 1000 -g 1000 www-data

# Install xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Copy the custom entrypoint script from the local directory into the image.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the custom entrypoint script executable so it can be run.
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set our custom script as the main command to run when the container starts.
ENTRYPOINT ["entrypoint.sh"]

# Provide the default command to the entrypoint, which is to start the Apache server.
CMD ["apache2-foreground"]