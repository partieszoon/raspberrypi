#!/bin/bash 
if wget -q -O - "$@" https://feed.tunein.com//profiles/s224031/nowplaying | grep -q "All I Want for Christmas"; then
    /home/pi/tg/bin/telegram-cli -k /home/pi/tg/tg-server.pub -W -e 'msg Partyzone! /gezellighd: All I want for christmas is youuuu!'
fi
