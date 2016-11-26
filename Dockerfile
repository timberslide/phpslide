FROM php:5.6.28

# Freshen up
RUN apt-get update

# Install composer
RUN apt-get install -yq zlib1g-dev
RUN cd /usr/local/bin && curl -sS https://getcomposer.org/installer | php
RUN cd /usr/local/bin && mv composer.phar composer

# Install gRPC library
RUN pecl install grpc

# Install dependencies from composer.json
RUN apt-get install -yq git
ADD composer.json /phpslide/composer.json
RUN cd /phpslide && composer install

# Install the library and example
ADD release/*.php /phpslide/
ADD *.php /phpslide/

# Run the example
CMD ["php", "-d", "extension=grpc.so", "-d", "max_execution_time=300", "/phpslide/example.php"]
