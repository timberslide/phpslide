FROM php:7-apache

RUN apt-get update && apt-get install -y -q git rake ruby-ronn zlib1g-dev && apt-get clean

# install composer
RUN cd /usr/local/bin && curl -sS https://getcomposer.org/installer | php
RUN cd /usr/local/bin && mv composer.phar composer

RUN pecl install grpc

#install protoc and Protobuf-PHP
RUN mkdir -p /tmp/protoc && \
    curl -L https://github.com/google/protobuf/releases/download/v3.0.2/protoc-3.0.2-linux-x86_64.zip > /tmp/protoc/protoc.zip && \
    cd /tmp/protoc && \
    unzip protoc.zip && \
    cp /tmp/protoc/bin/protoc /usr/local/bin && \
    cd /tmp && \
    rm -r /tmp/protoc

RUN cd /tmp && git clone https://github.com/stanley-cheung/Protobuf-PHP && \
    cd Protobuf-PHP && \
    rake pear:package version=1.0 && \
    pear install Protobuf-1.0.tgz && \
    cd /tmp && rm -r Protobuf-PHP

RUN apt-get install -yq vim

ADD . /phpslide
RUN cd /phpslide && composer install
RUN cd /phpslide && protoc -I . timberslide.proto --php_out=plugins=grpc:.
