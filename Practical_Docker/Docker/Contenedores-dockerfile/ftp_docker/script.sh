#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
echo "creando directorio"
mkdir -p  /var/ftp/empty
echo Modificando vsftpd.conf con sed
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
echo "configurando ip forwarding con echo"
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sed -i 's/#ftpd_banner=Welcome to blah FTP service./ftpd_banner=Hola usuario FTP/g' /etc/vsftpd.conf
sed -i 's%secure_chroot_dir=/var/run/vsftpd/empty%secure_chroot_dir=/var/ftp/empty%g' /etc/vsftpd.conf
echo creando usuario
adduser max --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "max:password" | chpasswd
echo "max" | tee -a /etc/vsftpd.userlist
service vsftpd start
