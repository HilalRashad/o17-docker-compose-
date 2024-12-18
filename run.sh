#!/bin/bash
DESTINATION=$1
PORT=$2
CHAT=$3
# clone Odoo directory
git clone --depth=1 https://github.com/HilalRashad/o17-docker-compose- $DESTINATION
rm -rf $DESTINATION/.git
# set permission
mkdir -p $DESTINATION/postgresql
sudo chmod -R 777 $DESTINATION
# config
if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf; fi
sudo sysctl -p
sed -i 's/10017/'$PORT'/g' $DESTINATION/Docker-Compose-Enhanced.yaml
sed -i 's/20017/'$CHAT'/g' $DESTINATION/Docker-Compose-Enhanced.yaml
# run Odoo
docker-compose -f $DESTINATION/Docker-Compose-Enhanced.yaml up -d

echo 'Started Odoo @ http://localhost:'$PORT' | Master Password: odoo17@2023 | Live chat port: '$CHAT
