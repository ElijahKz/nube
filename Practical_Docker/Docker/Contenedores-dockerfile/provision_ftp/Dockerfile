FROM ubuntu
MAINTAINER milmax
RUN apt-get update && apt-get upgrade -y
RUN apt-get install vsftpd -y

COPY script.sh /usr/sbin/
RUN chmod +x /usr/sbin/script.sh && \
		mkdir -p /var/run/vsftpd/empty

VOLUME /home/vsftpd
VOLUME /var/log/vsftpd

EXPOSE 20 21
RUN /usr/sbin/script.sh
CMD vsftpd
