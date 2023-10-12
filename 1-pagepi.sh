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

#re-enable X display server vs new Wayland. Becuse old tools for X dont work in Wayland. 
sudo sed -i "s/greeter-session=pi-greeter-wayfire/greeter-session=pi-greeter/" /etc/lightdm/lightdm.conf
sudo sed -i "s/user-session=LXDE-pi-wayfire/user-session=LXDE-pi-x/" /etc/lightdm/lightdm.conf
sudo sed -i "s/autologin-session=LXDE-pi-wayfire/autologin-session=LXDE-pi-x/" /etc/lightdm/lightdm.conf

#autohide taskbar by copying panel file to user profile and editing it disable updater notifications
sudo cp -a -f /etc/xdg/lxpanel /home/$USER/.config/
#sudo awk 'NR==FNR{if (/  type=updater/) for (i=-1;i<=3;i++) del[NR+i]; next} !(FNR in del)' /etc/xdg/lxpanel/LXDE-pi/panels/panel /etc/xdg/lxpanel/LXDE-pi/panels/panel > /home/$USER/.config/lxpanel/LXDE-pi/panels/panel
# edit file to hide panel
sudo sed -i "s/autohide=.*/autohide=1/" /home/$USER/.config/lxpanel/LXDE-pi/panels/panel
sudo sed -i "s/heightwhenhidden=.*/heightwhenhidden=0/" /home/$USER/.config/lxpanel/LXDE-pi/panels/panel
sudo sed -i '/  point_at_menu=0/a notifications=0' /home/$USER/.config/lxpanel/LXDE-pi/panels/panel



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
