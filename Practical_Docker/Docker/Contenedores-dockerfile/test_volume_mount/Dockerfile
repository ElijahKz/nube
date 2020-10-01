FROM centos
MAINTAINER milmax
RUN yum install httpd -y
RUN chmod -R 777 /var/www/html
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

