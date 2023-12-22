#!/bin/bash
cd ~
sudo sed -i '$i'"$(echo 'sh /home/'$USER'/3up.sh')" /home/$USER/.config/lxsession/LXDE-pi/autostart

cat > /home/$USER/3up.sh << EOLX
#!/bin/sh
# what this script does
DISPLAY=:0 xrandr --output HDMI-1 --rotate right

EOLX






cat > /home/$USER/myscript.sh << EOLP
#!/bin/sh
# what this script does: start chromium

chromium-browser --new-window --window-position=0,0 --window-size=2160,1280 --incognito --user-data-dir=/home/$USER/.config/chromium1 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.google.com/finance &

chromium-browser --new-window --window-position=0,1281 --window-size=2160,1280 --incognito --user-data-dir=/home/$USER/.config/chromium3 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://finviz.com/map.ashx?t=geo &

chromium-browser --new-window --window-position=0,2562 --window-size=2160,1280 --incognito --user-data-dir=/home/$USER/.config/chromium2 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://tradingview.com/markets/ &

EOLP


#add two more chromium window refreshes in since we have three chromiums running 

# line 50
echo 'WID=$(xdotool search --onlyvisible --class chromium|head -1)' >> /home/$USER/refresh.sh 
# line 51
echo 'xdotool windowactivate ${WID}' >> /home/$USER/refresh.sh 
# line 52
echo 'xdotool key ctrl+F5' >> /home/$USER/refresh.sh 

# line 50
echo 'WID=$(xdotool search --onlyvisible --class chromium|head -1)' >> /home/$USER/refresh.sh 
# line 51
echo 'xdotool windowactivate ${WID}' >> /home/$USER/refresh.sh 
# line 52
echo 'xdotool key ctrl+F5' >> /home/$USER/refresh.sh 
