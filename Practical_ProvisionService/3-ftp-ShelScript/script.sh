#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
echo "instalando un servidor vsftpd"
sudo apt-get install vsftpd -y
echo "-------------------------------------"
echo " Instalando firewall"
sudo apt-get install ufw -y
echo "-------------------------------------"
echo " Configurando firewall"
echo "Alloing 20/tcp"
sudo ufw allow 20/tcp
echo "Alloing 21/tcp"
sudo ufw allow 21/tcp
echo "-------------------------------------"
echo “Modificando vsftpd.conf con sed”
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
echo "configurando ip forwarding con echo"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "-------------------------------------"
echo "Negando permiso a usuarios anonimos"
sed -i 's/#anonymous_enable=No/anonymous_enable=No/g' /etc/vsftpd.conf
echo "-------------------------------------"
echo "cambiano el banner"
sudo echo "ftpd_banner= max Repos" >> /etc/vsftpd.conf
echo "creando usuario"
sudo adduser max --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password echo "max:password" | sudo chpasswd
echo "-------------------------------------"
echo "creando directorio ftp /home/vagrant/max/ftp"
sudo mkdir -p /home/vagrant/max/ftp
sudo chown nobody:nogroup /home/vagrant/max/ftp
sudo chmod a-w /home/vagrant/max/ftp
sudo ls -la /home/vagrant/max/ftp
echo "-------------------------------------"
echo "Directorio sincronizaco con el directorio host ftpFiles"
echo " Creando directorios contenedores de archivos"
sudo mkdir /home/vagrant/max/ftp/files
echo "-------------------------------------"
echo "asignando la propiedad al usuario"
sudo chown -R max:max /home/vagrant/max/ftp/files
echo "inicializando directorio"
echo "vsftpd sample file" | sudo tee /home/vagrant/max/ftp/files/sample.txt
echo "Agregando un user_sub_token en la ruta del directorio local_root"
sudo echo "user_sub_token=$USER" >> /etc/vsftpd.conf
echo "Permitiendo que la configuración actual funcione para el actual usuarios y posteriores"
sudo echo "local_root=/home/$USER/ftp" >> /etc/vsftpd.conf
echo "creando lista de acceso de los usuarios"
sudo echo "userlist_enable=YES" >> /etc/vsftpd.conf
sudo echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf
echo "Permitiendo acceso unicamente a los usuarios especificados en la lista"
sudo echo "userlist_deny=NO" >> /etc/vsftpd.conf
echo  " Agregando usuario a la lista"
echo "max" | sudo tee -a /etc/vsftpd.userlist
echo "verificando usuario"
cat /etc/vsftpd.userlist
sudo systemctl restart vsftpd
