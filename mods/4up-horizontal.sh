cat > /home/$USER/myscript.sh << EOLP
#!/bin/sh
# what this script does: start chromium

chromium-browser --new-window --window-position=0,0 --window-size=1920,1080 --incognito --user-data-dir=/home/$USER/.config/chromium1 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.google.com/finance &

chromium-browser --new-window --window-position=1920,0 --window-size=1920,1080 --incognito --user-data-dir=/home/$USER/.config/chromium2 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.cnbc.com/us-markets/ &

chromium-browser --new-window --window-position=0,1081 --window-size=1920,1280 --incognito --user-data-dir=/home/$USER/.config/chromium3 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.wsj.com/market-data?mod=finance_mdw_mdc &

chromium-browser --new-window --window-position=1921,1081 --window-size=1920,1080 --incognito --user-data-dir=/home/$USER/.config/chromium4 \
--enable-features=OverlayScrollbar,OverlayScrollbarFlashAfterAnyScrollUpdate,OverlayScrollbarFlashWhenMouseEnter \
--app=https://www.barchart.com/stocks/market-performance &

EOLP


#add three more chromium window refreshes in since we have three chromiums running 

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

# line 50
echo 'WID=$(xdotool search --onlyvisible --class chromium|head -1)' >> /home/$USER/refresh.sh 
# line 51
echo 'xdotool windowactivate ${WID}' >> /home/$USER/refresh.sh 
# line 52
echo 'xdotool key ctrl+F5' >> /home/$USER/refresh.sh 
