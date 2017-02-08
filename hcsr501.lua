hcsr501 = {};

function hcsr501.init(pin)
	local self = {}

	self.pin = pin or 6
	self.react = false
	gpio.mode(self.pin, gpio.INT)

    self.start_time = 0

    function self.motion_detected()
        self.start_time = tmr.now()

		print('Motion detected\n')

		if (self.react == true) then
			--XXX/this callback should be abstracted through class init
			servo.start_wiggle()
		else
			--led.enable()
		end

		gpio.trig(self.pin, "down", self.motion_stopped)
    end

    function self.motion_stopped()
		duration = (tmr.now() - self.start_time) / 1000 / 1000

		print('Motion ended after '..duration..' seconds.\n')

		servo.stop_wiggle()
		--led.disable() -- XXX/take this out later

		gpio.trig(self.pin, "up", self.motion_detected)

		-- post_to_ifttt("cat_toy_motion_sensed", ifttt_key, duration)
    end

    function self.stop()
        print('Motion sensor off\n')

		self.react = false
    end

	gpio.trig(self.pin, "up", self.motion_detected)

    print("Initialized motion sensor\n")

    return self
end
