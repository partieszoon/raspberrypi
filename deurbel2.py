#!/usr/bin/env python2.7
import RPi.GPIO as GPIO
import os
import time
from pytg.sender import Sender

time.sleep(20)
sender = Sender(host="localhost", port=4458)

GPIO.setmode(GPIO.BCM)

GPIO.setup(24, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
lastcall = time.time()


def my_callback(channel):
    global lastcall
    if time.time()-lastcall > 10:
        if int(time.strftime("%H")) > 7:
            os.system("/usr/bin/lua /home/pi/deurbelgeluid_1.1.lua &")
        os.system("fswebcam -r 1280x720 --set brightness=75% --set contrast=24% --title 'Partyzone Cam 1' --save /home/pi/image.jpg")
        sender.send_photo("chat#76493431", u"/home/pi/image.jpg", u"")
        lastcall = time.time()
GPIO.add_event_detect(24, GPIO.FALLING, callback=my_callback, bouncetime=3000)

while True:
    time.sleep(1)
