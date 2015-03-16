#!/bin/sh

curl -sS https://getcomposer.org/installer | php
php composer.phar config -g github-oauth.github.com fa7525e8f9e94549c13607b6cd110b9e3a3f1460
php composer.phar install
