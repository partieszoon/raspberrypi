from scapy.all import *
from pytg.sender import Sender
import time

time.sleep(20)
sender = Sender(host="localhost", port=4458)
sender.dialog_list()

def arp_display(pkt):
  if pkt[ARP].op == 1: #who-has (request)
    if pkt[ARP].hwsrc == '74:c2:46:92:91:1e':
      if int(time.strftime("%H")) > 19:
        sender.send_msg("chat#76493431", u"/gezelligheid! xxx Arie \xF0\x9F\x98\x98")
      elif int(time.strftime("%H")) > 16:
        sender.send_msg("chat#76493431", u"/eten!") 
      else:
        sender.send_msg("chat#76493431", u"/lunch!")

print sniff(prn=arp_display, filter="arp", store=0, count=0)

