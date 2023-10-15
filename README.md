# pagepi
Simple kiosk mode pi4 setup that shows an external web page on the TV attached.

Youtube walkthrough:
https://youtu.be/r2H2wu5l0kU?si=5oFrTSo499ySAL18

By default page refreshes every 15 minutes by keyboard simulation refresh. This script is compatible with this Raspian Bookworm from 10-10-2023. It does not use Wayland it changes back to X Server since some of the older tools like xdotool and unclutter don't work in Wayland. 

![raspbian](https://github.com/ugotapi/pagepi/assets/14945441/18d62fa5-5132-43a4-8662-9e30eba4d8ce)


Pagepi setup showing a popular financial charts website:
![unnamed](https://github.com/ugotapi/pagepi/assets/14945441/8a75fcaf-559f-4726-9a78-fe416704bafa)

