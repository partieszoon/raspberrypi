#!/bin/bash

if pgrep telegram >/dev/null 2>&1
then
    echo "Running"
else
    echo "Stopped. Restarting..."
    sudo /home/pi/tg/telegram -s /home/pi/tg/test.lua -k /home/pi/tg/tg-server.pub &
fi
