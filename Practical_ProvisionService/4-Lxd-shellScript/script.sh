echo "instalando snap lxd"
sudo snap install lxd --channel=4.0/stable
echo "---------------------------"
echo "Creando nuevo grupo lxd"
newgrp lxd
echo "---------------------------"
echo "Inicalizando el uso del contendor"
lxd init --auto
echo "---------------------------"
echo "lanzando la imagen de un contener ubuntu :web"
lxc launch ubuntu:20.04 web
echo "---------------------------"
echo "Limitando memoria del contendor a un consumo de 64MB"
lxc config set web limits.memory 64MB
echo "---------------------------"
echo "instalación de servidor apache"
lxc exec web -- apt install apache2 -y
echo "---------------------------"
echo "Montando servicio web en el contenedor"
lxc exec web -- systemctl restart apache2
echo "---------------------------"
echo "Creción de dispositvo para redireccionamiento de puertos"
lxc config device add web myport80 proxy listen=tcp:192.168.100.3:5080 connect=tcp:127.0.0.1:80