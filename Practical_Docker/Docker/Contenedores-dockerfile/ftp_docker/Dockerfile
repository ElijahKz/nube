FROM ubuntu
MAINTAINER milmax
RUN apt-get update && apt-get upgrade -y
RUN apt-get install vsftpd -y

RUN echo "nameserver=8.8.8.8" >> /etc/resolv.conf
RUN echo "creando directorio"
RUN mkdir -p  /var/ftp/empty
RUN echo Modificando vsftpd.conf con sed
RUN sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
RUN echo "configurando ip forwarding con echo"
RUN echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
RUN sed -i 's/#ftpd_banner=Welcome to blah FTP service./ftpd_banner=Hola usuario FTP/g' /etc/vsftpd.conf
RUN sed -i 's%secure_chroot_dir=/var/run/vsftpd/empty%secure_chroot_dir=/var/ftp/empty%g' /etc/vsftpd.conf
RUN echo creando usuario
RUN adduser max --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
RUN echo "max:password" | chpasswd
RUN echo "max" | tee -a /etc/vsftpd.userlist
RUN service vsftpd start

EXPOSE 20 21

CMD vsftpd



