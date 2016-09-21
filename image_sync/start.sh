#!/bin/sh
if [ -d "/usr/share/nginx/wordpress/wp-content/uploads" ];then
  if [ ! -L "/ovrride/wp-content/uploads" ];then
    mkdir -p /ovrride/wp-content/
    ln -s /usr/share/nginx/wordpress/wp-content/uploads /ovrride/wp-content/
  fi
fi

img_sync
