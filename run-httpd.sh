#!/bin/bash
# Copied from
#https://github.com/CentOS/CentOS-Dockerfiles/blob/master/httpd/centos7/run-httpd.sh
# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*
keystone-manage bootstrap --bootstrap-password my-secret-password

MYSQL_HOST=keystone-mariadb
MYSQL_PORT=3306

if [ -z "$MYSQL_PASSWORD" ]
then MYSQL_PASSWORD=$( cat /etc/keystone/dbpass.txt )
fi

openstack-config  --set  /etc/keystone/keystone.conf database connection mysql+pymysql://keystone:$MYSQL_PASSWORD@$MYSQL_HOST/keystone

exec /usr/sbin/apachectl -DFOREGROUND
