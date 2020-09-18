#!/bin/bash
sudo -i
sudo apt-get update && apt upgrade && apt autoremove -y
exit
echo "lanzando la imagen de un contener ubuntu :haproxy"
sudo lxc launch ubuntu:18.04 haproxy
echo "Limitando memoria del contendor a un consumo de 64MB"
sudo lxc config set haproxy limits.memory 64MB
echo "---------------------------"
echo "instalación de servidor haproxy "

sudo lxc exec haproxy -- apt update && apt upgrade && apt autoremove -y
echo "---------------------------"
echo "Montando servicio haproxy en el contenedor"
sudo lxc exec haproxy -- apt install haproxy -y
exit
exit
echo "---------------------------"

