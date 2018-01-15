#!/bin/sh
sleep 30

#set -e

until mysqladmin -hdb -u$REMOTE_DB_USER -p$REMOTE_DB_PASS ping > /dev/null 2>&1 && echo 1 || echo 0; do
  echo "Waiting for Maria Db to come up"
done
LOOPCOUNT=0
until gunzip -tf /db/ovrride.sql.gz; do
  LOOPCOUNT=$((LOOPCOUNT+1))
  if [ $LOOPCOUNT -gt 10 ]; then
    echo "Something went wrong, it's taking too long to download db!"
    exit 126
  else
    echo "Still waiting for DB to download..."
    sleep 10
  fi
done
echo "Connection successful"
echo "Decompressing Backup"
gunzip -f /db/ovrride.sql.gz
echo "Starting Import"
set -e

mysql -hdb -u$REMOTE_DB_USER -p$REMOTE_DB_PASS -e 'CREATE DATABASE IF NOT EXISTS ovrride'
pv -f /db/ovrride.sql | mysql -hdb -u$REMOTE_DB_USER -p$REMOTE_DB_PASS  ovrride
pv -f /ovr_dev.sql | mysql -hdb -u$REMOTE_DB_USER -p$REMOTE_DB_PASS  ovrride
