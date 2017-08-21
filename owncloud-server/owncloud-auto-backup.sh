#!/bin/sh

# Backup the dynamical components of the owncloud server (the mysql database).
# Backups older than 30 days will automatically be deleted. This script should
# be invoked regularly using cron or similar.

mkdir -p /srv/owncloud-conf/backup/mysql

mysqldump --lock-tables -hlocalhost -uroot -ppassport owncloud > \
/srv/owncloud-conf/backup/mysql/owncloud-`date +"%Y%m%d"`.sql

find /srv/owncloud-conf/backup/mysql -type f -mtime +30 -delete
