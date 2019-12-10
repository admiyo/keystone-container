FROM docker.io/centos:7
MAINTAINER Adam Young <adam@younglogic.com>
 
RUN yum install -y centos-release-openstack-stein &&\
    yum update -y &&\
    yum -y install openstack-keystone httpd mariadb openstack-utils mod_wsgi &&\
    yum -y clean all
 
RUN cp /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d
 
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
 
CMD ["/run-httpd.sh"]
