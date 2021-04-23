#!/bin/bash

echo "> writing general config"
/usr/bin/gomplate -V \
  -o /srv/www/config/config.php \
  -f /etc/templates/config.php.tmpl

if [[ $? -ne 0 ]]
then
  echo "> writing config failed!"
  /bin/s6-svscanctl -t /etc/s6
  exit 1
fi

echo "> writing auth config"
/usr/bin/gomplate -V \
  -o /srv/www/config/auth.php \
  -f /etc/templates/auth.php.tmpl

if [[ $? -ne 0 ]]
then
  echo "> writing config failed!"
  /bin/s6-svscanctl -t /etc/s6
  exit 1
fi

echo "> writing backups config"
/usr/bin/gomplate -V \
  -o /srv/www/config/backups.php \
  -f /etc/templates/backups.php.tmpl

if [[ $? -ne 0 ]]
then
  echo "> writing config failed!"
  /bin/s6-svscanctl -t /etc/s6
  exit 1
fi

echo "> writing database config"
/usr/bin/gomplate -V \
  -o /srv/www/config/database.php \
  -f /etc/templates/database.php.tmpl

if [[ $? -ne 0 ]]
then
  echo "> writing config failed!"
  /bin/s6-svscanctl -t /etc/s6
  exit 1
fi

echo "> writing modules config"
/usr/bin/gomplate -V \
  -o /srv/www/config/modules.php \
  -f /etc/templates/modules.php.tmpl

if [[ $? -ne 0 ]]
then
  echo "> writing config failed!"
  /bin/s6-svscanctl -t /etc/s6
  exit 1
fi

echo "> writing servers config"
/usr/bin/gomplate -V \
  -o /srv/www/config/servers.php \
  -f /etc/templates/servers.php.tmpl

if [[ $? -ne 0 ]]
then
  echo "> writing config failed!"
  /bin/s6-svscanctl -t /etc/s6
  exit 1
fi

if [[ -n "$MYWEBSQL_EXTERNAL_PATH" ]]
then
  echo "> creqating soft link"
  mv -v /srv/www "/srv/${MYWEBSQL_EXTERNAL_PATH}"
  mkdir -pv /srv/www
  chown -R caddy:caddy /srv/www
  mv -v "/srv/${MYWEBSQL_EXTERNAL_PATH}" /srv/www/
  #ln -sv /srv/www/ "/srv/www/${MYWEBSQL_EXTERNAL_PATH}"
fi