# Start from the official WordPress image
FROM wordpress:latest

# Change the container's web server user (www-data) to match
# the host user's ID (usually 1000) to prevent permission issues.
RUN usermod -u 1000 www-data