#!/bin/sh

# Restore the owncloud server. These commands can be executed as a script,
# provided <latest> is replaced by the latest backup date. Owncloud should be
# installed using owncloud-setup.sh first.

echo "Edit script first: replace <latest> by the latest backup date"
echo "NB!! <latest> might be different for different parts of the backup"
exit

# Restore the apache2 configuration
# install and enable sites
sudo cp /srv/owncloud-conf/backup/sites/owncloud-ssl-<latest>.conf \
        /etc/apache2/sites-available/owncloud-ssl.conf
sudo a2ensite owncloud-ssl
# verify ownership of installed files (this is probably unneccesary when the
# desired user is root and the files are copied into place using sudo cp)
#sudo chown root:root /etc/apache2/conf-available/*
#sudo chown root:root /etc/apache2/sites-available/*
#sudo chown root:root /etc/apache2/ports.conf

# Restore the owncloud configuration
sudo cp /srv/owncloud-conf/backup/config/config-<latest>.php \
        /var/www/nextcloud/config/config.php
sudo chown -R www-data:www-data /var/www/nextcloud/config

# Restore the database
mysql -hlocalhost -uroot -ppassport owncloud < \
      /srv/owncloud-conf/backup/mysql/owncloud-<latest>.sql

# restart apache2 to apply changes
sudo service apache2 restart
