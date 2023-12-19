#!/bin/sh
# 4 up web pages
#overwrite existing myscript.sh

cat > /home/$USER/myscript.sh << EOLP
#!/bin/sh
# what this script does: start chromium

chromium-browser --new-window --window-position=0,0 --window-size=1920,1080 --incognito --user-data-dir=/home/$USER/.config/chromium1 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.google.com/finance &

chromium-browser --new-window --window-position=1920,0 --window-size=1920,1080 --incognito --user-data-dir=/home/$USER/.config/chromium2 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://cnbc.com &

chromium-browser --new-window --window-position=0,1081 --window-size=1920,1280 --incognito --user-data-dir=/home/$USER/.config/chromium3 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.wsj.com &

chromium-browser --new-window --window-position=1921,1081 --window-size=1920,1080 --incognito --user-data-dir=/home/$USER/.config/chromium4 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.wsj.com &

EOLP


