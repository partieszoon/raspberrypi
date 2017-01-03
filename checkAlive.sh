#!/bin/bash

T=$(date +%s)
T2=$(($T-120))	
F=$(stat --printf=%Y tglog.txt | cut -d. -f1)

if [ $T2 -ge  $F ]; then
 	sudo reboot	
else
	echo "Alive"
fi
