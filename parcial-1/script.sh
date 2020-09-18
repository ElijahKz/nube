#!/bin/bash
#sudo apt-get update && apt upgrade && apt autoremove -y
echo "lanzando la imagen de un contener ubuntu :web1 y web2"
sudo lxc launch ubuntu:18.04 web1
sudo lxc launch ubuntu:18.04 web2
echo "Limitando memoria del contendor a un consumo de 64MB"
sudo lxc config set web1 limits.memory 64MB
sudo lxc config set web2 limits.memory 64MB
echo "---------------------------"
echo "instalación de servidor apache"
sudo lxc exec web1 -- apt update && apt upgrade && apt autoremove -y
sudo lxc exec web2 -- apt update && apt upgrade && apt autoremove -y
sudo lxc exec web1 -- apt install apache2 -y
sudo lxc exec web2 -- apt install apache2 -y
echo "Montando servicio web en el contenedor"
sudo lxc exec web1 -- systemctl restart apache2
sudo lxc exec web2 -- systemctl restart apache2