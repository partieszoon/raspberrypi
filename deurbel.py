import RPi.GPIO as GPIO
import time
import os

channel = 24

def my_callback(channel):
    print "deurbel"


GPIO.setmode(GPIO.BCM)

GPIO.setup(channel, GPIO.IN)

GPIO.wait_for_edge(channel, GPIO.FALLING)

GPIO.add_event_detect(channel, GPIO.FALLING, callback=my_callback)

#while True:
#    input_state = GPIO.input(24)
#    if input_state == False:
#        print(GPIO.input(24))
#        os.system("/usr/bin/lua /home/pi/deurbelgeluid_1.1.lua &")
#        os.system("/home/pi/tg/bin/telegram-cli -k /home/pi/tg/tg-server.pub -W -e 'msg Partyzone! /deurbel!'")
#        time.sleep(30)
#        os.system("reboot")
#        
