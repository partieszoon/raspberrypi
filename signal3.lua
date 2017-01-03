local gpio1 = require("GPIO")
local gpio2 = require("GPIO")

local sleep = function(seconds)
  os.execute("sleep "..tostring(seconds).."s")
end

gpio1.setmode(gpio1.BCM)
gpio2.setmode(gpio2.BCM)
local pinout1= 17
local pinout2= 27

gpio1.setup{
   channel=pinout1,
   direction=gpio1.OUT,
   initial=gpio1.LOW,
}
gpio2.setup{
   channel=pinout2,
   direction=gpio2.OUT,
   initial=gpio2.LOW,
}


pwm1 = gpio1.newPWM(pinout1, 100) -- PWM instance at 100 Hz
pwm1:start(0)  -- dutycycle at 0%
pwm2 = gpio2.newPWM(pinout2, 100) -- PWM instance at 100 Hz
pwm2:start(0)  -- dutycycle at 0%

delay = 0.12
delta = 10
program = {0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 95, 90, 85, 80, 75, 70, 65, 60, 55, 50, 45, 40, 35, 30, 25, 20, 15, 10, 0}
--program = {10,15,20,15,10}

for stepCount = 1, #program+delta do
  if (program[stepCount] ~= nil) then
    pwm1:ChangeDutyCycle(program[stepCount])
    print ('a' .. program[stepCount])
  end
  if (program[stepCount-delta] ~= nil) then
    pwm2:ChangeDutyCycle(program[stepCount-delta])
    print ('b' .. program[stepCount-delta])
  end
  sleep(delay)
end


pwm1:stop()
pwm2:stop()
gpio1.cleanup()
gpio2.cleanup()
