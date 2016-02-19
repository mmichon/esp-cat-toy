function connect_wifi (ap, password)
    print("Connecting to network")

    wifi.sleeptype(wifi.MODEM_SLEEP)
    wifi.setmode(wifi.STATION)
    wifi.sta.config(ap, password)
end

function read_file(filename)
    local content = ""
    local line = ""

    file.open(filename, "r")
    
    -- NodeMCU has a size limit with file.read() so reading line by line is necessary :(
    repeat
        line = file.readline()
        if line ~= nil then content = content .. line; end
    until line == nil    
    
    file.close()

    return content
end

function blink_gpio (gpio_pin, how_many_times)
    for times = 1,how_many_times do
        gpio.write(gpio_pin,gpio.LOW)
        tmr.delay(blink_ms*1000)
        
        gpio.write(gpio_pin,gpio.HIGH)
        tmr.delay(blink_ms*1000)
    end
end

function pulse_gpio (gpio_pin, ms)
    local pinon = 0

    tmr.alarm(0, ms, 1, function()
        if pinon == 0 then
            pinon = 1
            gpio.write(gpio_pin, gpio.LOW)
        else
            pinon = 0
            gpio.write(gpio_pin, gpio.HIGH)
        end
    end, us)
end