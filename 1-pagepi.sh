#!/bin/bash
ifconfig
# Ask the user for info
read -p 'What is the website url:? ' webvar


echo Site you want to display on TV? $webvar
while true; do
    read -p "Is the above info correct? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo continuing


#enable ssh server
sudo systemctl enable ssh 
sudo systemctl start ssh
sudo apt update
sudo apt upgrade -y
cd ~

sed -i '/updater/d' /home/$USER/.config/wf-panel-pi.ini
cat >> /home/$USER/.config/wf-panel-pi.ini << EOL
# automatically hide when pointer isn't over the panel
autohide=true
# The minimal size of the panel. Note that some widgets might force panel bigger than this size.
# All widgets also have individual settings for size
# Changing this requires a panel restart
minimal_height=45
# time in milliseconds to wait before hiding
autohide_duration=300
EOL



#hide mouse when no movement allow programmed refresh
sudo apt install xdotool unclutter -y


# no window border
sudo mkdir ~/.config/openbox
sudo cp /etc/xdg/openbox/rc.xml  ~/.config/openbox/rc.xml
sudo sed -i "s/<keepBorder>yes/<keepBorder>no/" ~/.config/openbox/rc.xml

# no decorations
sudo sed -i "s#</applications>#<application class=\"*\"> <decor>no</decor>  </application> </applications>#" ~/.config/openbox/rc.xml

#no blank screen
mkdir /home/$USER/.config/lxsession
mkdir /home/$USER/.config/lxsession/LXDE-pi
cp /etc/xdg/lxsession/LXDE-pi/autostart /home/$USER/.config/lxsession/LXDE-pi/
sudo echo '@xset s noblank' >> /home/$USER/.config/lxsession/LXDE-pi/autostart
sudo echo '@xset -dpms' >> /home/$USER/.config/lxsession/LXDE-pi/autostart
sudo echo '@xset s off' >> /home/$USER/.config/lxsession/LXDE-pi/autostart
sudo echo "sh /home/$USER/myscript.sh" >> /home/$USER/.config/lxsession/LXDE-pi/autostart

#change setting to openbox
sudo cp /etc/xdg/lxsession/LXDE-pi/desktop.conf /home/$USER/.config/lxsession/LXDE-pi/desktop.conf
sudo sed -i "s/window_manager=.*/window_manager=openbox/" /home/$USER/.config/lxsession/LXDE-pi/desktop.conf



#create the file that starts Chromium a displays a web page. myscript is what you edit to get a different web page on the TV. 
cat > /home/$USER/myscript.sh << EOL
#!/bin/sh
# what this script does: start chromium

chromium-browser --new-window --window-position=0,0 --window-size=3840,2160 --incognito --user-data-dir=/home/$USER/.config/chromium2 --enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter --app=$webvar &

EOL

sudo chmod +x /home/$USER/myscript.sh


## black blackground and disable notifications
mkdir /home/$USER/.config/pcmanfm
mkdir /home/$USER/.config/pcmanfm/LXDE-pi
cat > /home/$USER/.config/pcmanfm/LXDE-pi/desktop-items-0.conf << EOL
[*]
desktop_bg=#000000
desktop_shadow=#000000
desktop_fg=#E8E8E8
desktop_font=PibotoLt 12
wallpaper=/usr/share/rpd-wallpaper/clouds.jpg
wallpaper_mode=color
show_documents=0
show_trash=0
show_mounts=0
EOL


# refresh screen local via keyboard emulation
echo '#!/bin/sh' > /home/$USER/refresh.sh 
echo '# blah blah' >> /home/$USER/refresh.sh 
echo 'WID=$(xdotool search --onlyvisible --class chromium|head -1)' >> /home/$USER/refresh.sh 
echo 'xdotool windowactivate ${WID}' >> /home/$USER/refresh.sh 
echo 'xdotool key ctrl+F5' >> /home/$USER/refresh.sh 

sudo chmod +x /home/$USER/refresh.sh 

cd ~
# refresh every 15 minutes
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "*/15 * * * * DISPLAY=:0 /home/$USER/refresh.sh" >> mycron
#install new cron file
crontab mycron
rm mycron


read -p "After this reboot webisgte should display. To edit the website displayed edit: /home/$USER/myscript.sh  Hit Enter key to continue"
sudo reboot
