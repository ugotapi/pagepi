#!/bin/sh
# what this script does: start chromium

DISPLAY=:0 xrandr --output HDMI-1 --rotate right

#overwrite existing myscript.sh

cat > /home/$USER/myscript.sh << EOL

#!/bin/sh
# what this script does: start chromium

chromium-browser --new-window --window-position=0,0 --window-size=2160,1280 --incognito --user-data-dir=/home/$USER/.config/chromium2 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.google.com/finance &

chromium-browser --new-window --window-position=0,0 --window-size=2160,1280 --incognito --user-data-dir=/home/$USER/.config/chromium2 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://cnbc.com &

chromium-browser --new-window --window-position=0,0 --window-size=2160,1280--incognito --user-data-dir=/home/$USER/.config/chromium2 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.wsj.com &

EOL  

sudo reboot


