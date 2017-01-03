-- Blinks led on P0 / pin11
-- Exits after 10 blinks

local gpio = require("GPIO")

local sleep = function(seconds)
  os.execute("sleep "..tostring(seconds).."s")
end

gpio.setmode(gpio.BCM)
gpio.setup(17, gpio.OUT)

gpio.output(17, gpio.HIGH)
sleep(0.6)
gpio.output(17, gpio.LOW)

gpio.cleanup()

