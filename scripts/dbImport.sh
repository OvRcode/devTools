#!/bin/sh
sleep 30

#set -e

until mysqladmin -hdb -u$REMOTE_DB_USER -p$REMOTE_DB_PASS ping > /dev/null 2>&1 && echo 1 || echo 0; do
  echo "Waiting for Maria Db to come up"
done

echo "Connection successful"
echo "Decompressing Backup"
gunzip -f /db/ovrride.sql.gz
echo "Starting Import"
set -e

pv -f /db/ovrride.sql | mysql -hdb -u$REMOTE_DB_USER -p$REMOTE_DB_PASS
pv -f /ovr_dev.sql | mysql -hdb -u$REMOTE_DB_USER -p$REMOTE_DB_PASS
