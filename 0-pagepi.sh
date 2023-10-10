#!/bin/bash
cd ~
sudo apt update 
sudo apt upgrade -y
wget https://raw.githubusercontent.com/ugotapi/pagepi/main/1-pagepi.sh
sudo chmod +x /home/$USER/*.sh
/home/$USER/1-pagepi.sh
