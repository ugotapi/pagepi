#!/bin/bash
wget https://raw.githubusercontent.com/rudischmitz71/blahblah/main/1-tablepi.sh
wget https://raw.githubusercontent.com/rudischmitz71/blahblah/main/4-finalize-tablepi.sh
cp /home/$USER/4-finalize-tablepi.sh /home/$USER/Desktop/4-finalize-tablepi.sh
sudo chmod +x /home/$USER/*.sh
/home/$USER/1-tablepi.sh
