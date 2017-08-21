#!/bin/sh

# Backup the static configuration of the owncloud server. This script should be
# invoked manually after editing the configuration.

mkdir -p /srv/owncloud-conf/backup/sites/
mkdir -p /srv/owncloud-conf/backup/config/
mkdir -p /srv/owncloud-conf/backup/mysql/

sudo cp /etc/apache2/sites-available/owncloud-ssl.conf \
        /srv/owncloud-conf/backup/sites/owncloud-ssl-`date +"%Y%m%d"`.conf
sudo chown brothers:brothers \
        /srv/owncloud-conf/backup/sites/owncloud-ssl-`date +"%Y%m%d"`.conf

sudo cp /var/www/nextcloud/config/config.php \
        /srv/owncloud-conf/backup/config/config-`date +"%Y%m%d"`.php
sudo chown brothers:brohters \
        /srv/owncloud-conf/backup/config/config-`date +"%Y%m%d"`.php

mysqldump --lock-tables -hlocalhost -uroot -ppassport owncloud > \
          /srv/owncloud-conf/backup/mysql/owncloud-`date +"%Y%m%d"`.sql
