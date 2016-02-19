-- GPIO2 is not used
gpio1 = 3
gpio2 = 4
gpio.mode(gpio1, gpio.OUTPUT)
gpio.mode(gpio2, gpio.OUTPUT)

servo = {}
servo.pin = gpio1 -- Hook up servo signal line to GPIO1
servo.pulse = 50 -- These duty cycles should be good for any SG90 servo
servo.left = 160
servo.right = 43

function start_servo(initial_position)
    if(initial_position == nil) then initial_position = 50 end

    print("Started servo with initial position: "..initial_position)
    
    ms = initial_position * (servo.left-servo.right) / 100 + servo.right
    
    pwm.setup(servo.pin, servo.pulse, ms)
    pwm.start(servo.pin)

    -- Give the servo enough time to travel before doing anything else
    tmr.delay(1000*1000)
end

function stop_servo()
    print("Stopped servo")
    pwm.stop(servo.pin)
end

function set_servo_position(position)
    ms = position * (servo.left-servo.right) / 100 + servo.right
    
    print("Set server to position: "..position.." ms: "..ms)
    
    pwm.setduty(servo.pin, ms)
end

function center_servo()
    print("Centering servo")
    set_servo_position(50)
end

function start_wiggle_servo(ms)
    print("Starting random wiggle")

    tmr.alarm(1, ms, 1, function()
        set_servo_position(math.random(1, 100)) -- This is for wiggling through the full travel range
    end)
end

function stop_wiggle_servo()
    print("Stopping random wiggle")
   
    tmr.stop(1)
end