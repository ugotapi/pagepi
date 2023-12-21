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

chromium-browser --new-window --window-position=0,0 --window-size=2160,1080 --incognito --user-data-dir=/home/$USER/.config/chromium1 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.google.com/finance &

chromium-browser --new-window --window-position=0,1281 --window-size=2160,1080 --incognito --user-data-dir=/home/$USER/.config/chromium2 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.cnbc.com/us-markets/ &

chromium-browser --new-window --window-position=0,2562 --window-size=2160,1080 --incognito --user-data-dir=/home/$USER/.config/chromium3 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.wsj.com/market-data?mod=finance_mdw_mdc &

EOLP
