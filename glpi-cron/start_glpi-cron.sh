#!/bin/sh

# Modify default timezone for PHP
sed -i "s|;date.timezone =|date.timezone=${TZ}|" /etc/php81/php.ini

# Modify default cookie_httponly value for security purpose
sed -i "s|session.cookie_httponly =|session.cookie_httponly = 1|" /etc/php81/php.ini

# Waiting for the installation to be done
echo `date` " - Waiting GLPI to be installed from ppcm/glpi-server"
done_file='/var/glpi/config/.installation_done'
while [ ! -f "$done_file" ]
do
    inotifywait -qq -t 30 -e create -e moved_to "$(dirname $done_file)"
done

echo `date` " - GLPI cron job begins"

# Run GLPI cron script
su apache -s /bin/ash -c "cd /var/www/glpi; /usr/bin/php front/cron.php"

echo `date` " - GLPI cron job finished"
