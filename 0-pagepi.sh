#!/bin/bash
ifconfig
# Ask the user for info
read -p 'What is thew website url - https://www.google.com/news ' webvar





echo Site you want to display on tv: $webvar
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
cd ~


#autohide taskbar by copying panel file to user profile and editing it. 
sudo awk 'NR==FNR{if (/  type=updater/) for (i=-1;i<=3;i++) del[NR+i]; next} !(FNR in del)' /etc/xdg/lxpanel/LXDE-pi/panels/panel /etc/xdg/lxpanel/LXDE-pi/panels/panel > /home/$USER/.config/lxpanel/LXDE-pi/panels/panel
# edit file to disable updater notifications
sudo sed -i "s/autohide=.*/autohide=1/" /home/$USER/.config/lxpanel/LXDE-pi/panels/panel
sudo sed -i "s/heightwhenhidden=.*/heightwhenhidden=0/" /home/$USER/.config/lxpanel/LXDE-pi/panels/panel


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
#get new file from O365
echo "pwsh /home/$USER/getstuff.ps1" >> /home/$USER/refresh.sh
echo '# blah blah' >> /home/$USER/refresh.sh 
echo 'WID=$(xdotool search --onlyvisible --class chromium|head -1)' >> /home/$USER/refresh.sh 
echo 'xdotool windowactivate ${WID}' >> /home/$USER/refresh.sh 
echo 'xdotool key ctrl+F5' >> /home/$USER/refresh.sh 

sudo chmod +x refresh.sh 


## install Wordpress locally
sudo apt install apache2 -y
sudo apt install php php-gd php-curl php-dom php-imagick php-mbstring php-zip php-intl -y
cd /var/www/html/
sudo rm index.html
sudo apt install mariadb-server php-mysql -y

sudo rm /var/www/html/index.html
cd /var/www/html/
ls
sudo wget http://wordpress.org/latest.tar.gz
sudo tar xzf latest.tar.gz
ls
sudo mv wordpress/* .
ls
sudo rm -rf wordpress latest.tar.gz
sudo chown -R www-data: /var/www/html/
# secure mariadb installation
read -p "now running mariadb secure install script. Press any key to resume ..."
sudo mysql_secure_installation

sudo mysql -e "CREATE DATABASE wordpressdb";
sudo mysql -e "CREATE USER wpuser@localhost IDENTIFIED BY '$passvar'";
sudo mysql -e "GRANT ALL ON wordpressdb.* TO wpuser@localhost IDENTIFIED BY '$passvar'";


#display xlsx with wordpress local install
#note this doesnt work for Office365 MFA enabled users or subfolders under sharepoint unless the script is edited.


#install wp-cli wordpress cli and some modules
cd ~
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

#install powershell on pi4
sudo apt-get install wget libssl1.1 libunwind8 -y
sudo mkdir -p /opt/microsoft/powershell/7
wget -O /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.3.7/powershell-7.3.7-linux-arm64.tar.gz 
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7
sudo chmod +x /opt/microsoft/powershell/7/pwsh
sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
rm /tmp/powershell.tar.gz
echo "Install-Module -Name PnP.PowerShell -Force" > /home/$USER/temp.ps1
pwsh /home/$USER/temp.ps1 -NonInteractive

#install python and openpyxl
sudo apt-get install python3 python3-pip
sudo pip3 install openpyxl

#powershell to get file from office365
#powershell to get file from office365
echo "Remove-Item -Path \"/home/$USER/*.xlsx\" -Recurse -Force -Confirm:\$false" > /home/$USER/getstuff.ps1 
echo "Remove-Item -Path \"/home/$USER/*.csv\" -Recurse -Force -Confirm:\$false" >> /home/$USER/getstuff.ps1 
echo "#Config Variables" >> /home/$USER/getstuff.ps1
echo "\$SiteURL = \"https://$spovar.sharepoint.com/sites/$sitenamevar\"" >> /home/$USER/getstuff.ps1
echo "\$FileRelativeURL = \"/sites/$sitenamevar/Shared Documents/$o365filename\"" >> /home/$USER/getstuff.ps1
echo "\$DownloadPath =\"/home/$USER/\"" >> /home/$USER/getstuff.ps1
echo "\$username=\"$o365username\"" >> /home/$USER/getstuff.ps1
echo "\$encpassword = convertto-securestring -String \"$o365userpassword\" -AsPlainText -Force" >> /home/$USER/getstuff.ps1 
echo "\$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist \$username, \$encpassword" >> /home/$USER/getstuff.ps1
echo "Connect-PnPOnline -Url \$SiteURL -Credentials \$cred " >> /home/$USER/getstuff.ps1
echo "Get-PnPContext" >> /home/$USER/getstuff.ps1
echo "#powershell download file from sharepoint online" >> /home/$USER/getstuff.ps1
echo "Get-PnPFile -Url \$FileRelativeURL -Path \$DownloadPath -AsFile -FileName \"$o365filenamepost\"" >> /home/$USER/getstuff.ps1 
echo "#edit xlsx file and get to csv" >> /home/$USER/getstuff.ps1
echo "python /home/$USER/runme.py" >> /home/$USER/getstuff.ps1
echo "#copy to apache folder" >> /home/$USER/getstuff.ps1
echo "sudo cp -f /home/$USER/output.csv /var/www/html" >> /home/$USER/getstuff.ps1
echo "sudo chown www-data:www-data /var/www/html/output.csv" >> /home/$USER/getstuff.ps1

# create python file to change to excel contents around if needed and save as csv
cat > /home/$USER/runme.py << EOL
import openpyxl
from openpyxl import load_workbook
wb = load_workbook(filename = '/home/$USER/$o365filenamepost')
ws = wb.active
# UNMERGE CELLS ws.unmerge_cells(start_row=1, start_column=1, end_row=1, end_column=10)
# DELETE A ROW ws.delete_rows(1)
wb.save('/home/$USER/output.xlsx')
## XLSX TO CSV
import openpyxl
import csv
wb = openpyxl.load_workbook('/home/$USER/$o365filenamepost')
sh = wb.active # was .get_active_sheet()
with open('/home/$USER/output.csv', 'w', newline="") as file_handle:
    csv_writer = csv.writer(file_handle)
    for row in sh.iter_rows(): # generator; was sh.rows
        csv_writer.writerow([cell.value for cell in row])
EOL


read -p "After this reboot 1. Setup wordpress. 2. Then run the 4-finalize-tablepi.sh on the Desktop. Hit Enter key to continue"
sudo reboot
