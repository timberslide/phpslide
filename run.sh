#!/bin/bash

php -d extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/grpc.so \
    -d max_execution_time=300 \
    example.php
