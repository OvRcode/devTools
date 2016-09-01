#!/bin/sh

cat << EOF > /root/.my.cnf
[client]
user=$DB_USER
password=$DB_PASS
EOF

chmod 600 /root/.my.cnf
