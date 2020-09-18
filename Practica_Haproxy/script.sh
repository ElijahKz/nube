echo "instalando snap lxd"
sudo snap install lxd --channel=4.0/stable
echo "---------------------------"
echo "Creando nuevo grupo lxd"
newgrp lxd
echo "---------------------------"
echo "Inicalizando el uso del contendor"
lxd init --auto
echo "---------------------------"
echo "lanzando la imagen de un contener ubuntu :web1 y web2"
lxc launch ubuntu:18.04 web1
lxc launch ubuntu:18.04 web2
lxc launch ubuntu:18.04 web3
lxc launch ubuntu:18.04 haproxy
echo "---------------------------"
echo "Limitando memoria del contendor a un consumo de 64MB"
lxc config set web1 limits.memory 64MB
lxc config set web2 limits.memory 64MB
lxc config set web3 limits.memory 64MB
lxc config set haproxy limits.memory 64MB
echo "---------------------------"
echo "instalación de servidor apache"
lxc exec web1 -- apt update && apt upgrade -y
lxc exec web2 -- apt update && apt upgrade -y
lxc exec web3 -- apt update && apt upgrade -y

lxc exec web1 -- apt install apache2 -y
lxc exec web2 -- apt install apache2 -y
lxc exec web3 -- apt install apache2 -y
echo "---------------------------"
echo "Montando servicio web en el contenedor y servicio haproxy"
lxc exec web1 -- systemctl restart apache2
lxc exec web2 -- systemctl restart apache2
lxc exec web3 -- systemctl restart apache2
vagrant ssh servidorHaproxy
lxc exec haproxy /bin/bash
apt update && apt upgrade -y
apt install haproxy -y
exit
exit
echo "---------------------------"
echo "Creción de dispositvo para redireccionamiento de puertos"
lxc config device add web1 device1 proxy listen=tcp:192.168.100.3:5080 connect=tcp:127.0.0.1:80
lxc config device add web2 device2 proxy listen=tcp:192.168.100.3:5081 connect=tcp:127.0.0.1:80
lxc config device add web3 device3 proxy listen=tcp:192.168.100.3:5082 connect=tcp:127.0.0.1:80


