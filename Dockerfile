# Use the official PHP image as base
FROM php:apache

# Set environment variables
ENV DOKUWIKI_URL="https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz"

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and extract latest version of DokuWiki
RUN wget -O /tmp/dokuwiki.tgz "${DOKUWIKI_URL}" && \
    tar -xzvf /tmp/dokuwiki.tgz -C /var/www/html/ --strip-components=1 && \
    rm /tmp/dokuwiki.tgz

# Configure Apache to serve DokuWiki
RUN chown -R www-data:www-data /var/www/html/ && \
    a2enmod rewrite

# Expose port
EXPOSE 80
EXPOSE 443

# Start Apache
CMD ["apache2-foreground"]
