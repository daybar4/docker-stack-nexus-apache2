#!/bin/bash
set -e
mkdir /var/run/apache2
cd /var/run/apache2
source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND