#!/bin/sh
sudo apt-get install apache2
echo -e "<VirtualHost *:80>
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
	Alias / /var/www/
	<Directory /var/www/>
   		IndexOptions FancyIndexing FoldersFirst
   		Options MultiViews Indexes
    		AllowOverride None
    		Order allow,deny
    		Allow from all
	</Directory>
</VirtualHost>
" > /etc/apache2/sites-available/000-default.conf
rm -r /var/www/html
service apache2 restart
