#!/bin/sh

cat << EOF > /root/.my.cnf
[client]
user=$1
password=$2
EOF

chmod 600 /root/.my.cnf
