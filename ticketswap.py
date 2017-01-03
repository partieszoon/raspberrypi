from pytg.sender import Sender
import time
import requests

sender = Sender(host="localhost", port=4458)
sender.dialog_list()

while True:
    r = requests.get('https://www.ticketswap.nl/m/event/708b17b4-4bc8-429f-ad2c-5ac656414dc4/type/46171?event_slug=elrow-amsterdam-nye&event_type_slug=regular')
    if "Helaas" in r.text:
        print "Geen tickets  beschikbaar"
    else:
        sender.send_msg("chat#76493431", u"/gezelligheid! tickets beschikbaar!")
        time.sleep(600) 
    time.sleep(1)
