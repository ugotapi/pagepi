# pagepi
Simple Digital Signage mode pi4 setup that shows an external web page on the TV attached.

Youtube walkthrough:
https://youtu.be/r2H2wu5l0kU?si=5oFrTSo499ySAL18

Remote setup on ssh server enabled new install of Raspberry Pi OS: https://youtu.be/mfGwRGGV6Yw

By default the page refreshes every 15 minutes by keyboard simulation refresh. This script is compatible with this Raspian Bookworm from 10-10-2023. It does not use Wayland it changes back to X Server since some of the older tools like xdotool and unclutter don't work in Wayland. 

![raspbian](https://github.com/ugotapi/pagepi/assets/14945441/18d62fa5-5132-43a4-8662-9e30eba4d8ce)


Pagepi setup showing a popular financial charts website:
![unnamed](https://github.com/ugotapi/pagepi/assets/14945441/8a75fcaf-559f-4726-9a78-fe416704bafa)


3UP portait mode PagePi


Do the Pagepi install following the youtube above. Then download and run the 3up script in this repo.
https://github.com/ugotapi/pagepi/blob/main/mods/3up-portrait.sh


Reboot to get a three page portait setting Digital Signage. Change specific web pages displayed afterwards by editing 3up-portrait.sh file or the myscript.sh file under the user profile on the Raspberry Pi. 


![3upfinance](https://github.com/ugotapi/pagepi/assets/14945441/d506c11a-37b2-4748-8c5a-949511fb5a2f)




