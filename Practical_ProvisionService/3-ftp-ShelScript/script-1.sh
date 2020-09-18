#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
echo "instalando un servidor vsftpd"
sudo apt-get install vsftpd -y
echo “Modificando vsftpd.conf con sed”
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
echo "configurando ip forwarding con echo"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sed -i 's/#ftpd_banner=Welcome to blah FTP service./ftpd_banner=Hola usuario FTP/g' /etc/vsftpd.conf
echo “creando usuario”
sudo adduser max --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "max:password" | sudo chpasswd