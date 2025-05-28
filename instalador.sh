#!/bin/bash

# Verificar que el usuario es root
if [[ $EUID -ne 0 ]]; then
   echo "Este script debe ejecutarse como root."
   exit 1
fi

# Mostrar el menú
OPCION=$(whiptail --title "Instalador de servicios" --menu "Selecciona un servicio para instalar:" 20 60 10 \
"1" "Apache" \
"2" "Nginx" \
"3" "Docker" \
"4" "Zabbix Agent" \
"5" "Salir" 3>&1 1>&2 2>&3)

# Acción según la opción elegida
case $OPCION in
  1)
    echo "Instalando Apache..."
    apt update && apt install apache2 -y
    ;;
  2)
    echo "Instalando Nginx..."
    apt update && apt install nginx -y
    ;;
  3)
    echo "Instalando Docker..."
    apt update && apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update && apt install docker-ce -y
    ;;
  4)
    echo "Instalando Zabbix Agent..."
    apt update && apt install zabbix-agent -y
    ;;
  5)
    echo "Saliendo del instalador."
    exit 0
    ;;
  *)
    echo "Opción no válida."
    ;;
esac
