servo_controller = {}

function servo_controller.init(pin, freq, left_us, right_us, center_us)
    local self = {}

    self.pin = pin or 5
    self.freq = freq or 50
    self.pulse_width = 1000 / self.freq -- in ms
    left_us = left_us or 250
    center_us = center_us or 1500
    right_us = right_us or 2500
    self.left_cycles = 10 -- (left_us/self.pulse_width)
    -- self.center_cycles = (center_us/self.pulse_width)
    self.right_cycles = 50 -- (right_us/self.pulse_width)

    gpio.mode(self.pin, gpio.OUTPUT)

    -- XXX/get rid of the unused functions
    function self.start(initial_position, duty_cycles, delay_ms)
        -- center the servo if no initial position provided
        initial_position = initial_position or 0
        duty_cycles = duty_cycles or initial_position * (self.right_cycles-self.left_cycles) / 100 + self.left_cycles
        delay_ms = delay_ms or 250
        pulse_ms = duty_cycles * self.pulse_width

        print("Started servo with initial position "..initial_position.."% @ "..duty_cycles.." cycles ("..pulse_ms.." ms) with "..delay_ms.." ms post-command delay\n")

        pwm.setup(self.pin, self.pulse_width, duty_cycles)
        pwm.start(self.pin)

        -- Give the servo enough time to travel before doing anything else
        tmr.delay(delay_ms * 1000)
    end

    function self.stop()
        print("Stopped servo\n")

        self.set_position(0)
        pwm.stop(self.pin)
    end

    function self.set_position(position)
        duty_cycles = position * (self.right_cycles-self.left_cycles) / 100 + self.left_cycles

        -- print("Set server to position: "..position.." ms: "..ms\n)

        pwm.setduty(self.pin, duty_cycles)
    end

    function self.center()
        print("Centering servo\n")

        self.set_position(50)
    end

    function self.start_wiggle(every_ms, min_travel, max_travel)
        ms = every_ms or 250
        min_travel = min_travel or 0
        max_travel = max_travel or 70

        print("Starting random wiggle every "..ms.." ms from "..min_travel.."% to "..max_travel.."%\n")

        pwm.setup(self.pin, self.pulse_width, self.left_cycles)
        pwm.start(self.pin)
        --tmr.delay(250*1000)

        tmr.alarm(1, ms, 1, function()
            self.set_position(math.random(min_travel, max_travel))
        end)
    end

    function self.stop_wiggle()
        print("Stopping random wiggle\n")
        self.set_position(25)
        tmr.delay(250*1000)

        tmr.stop(1)
        pwm.stop(self.pin)
    end

    self.start(50)
    self.start(25)
    self.stop()

    return self
end
