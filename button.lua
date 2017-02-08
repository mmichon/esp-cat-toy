switch_driver = {};

function switch_driver.init(pin)
	local self = {}

	self.pin = pin or 1

	gpio.mode(self.pin, gpio.INT)

	function self.switched(level)
		level = gpio.read(self.pin)
		print("Switch at GPIO"..self.pin.." switched to "..level.."\n")

		sensor.react = (level == 1)
	end

	initial_state = gpio.read(self.pin)
	print("Initial switch state: "..initial_state.."\n")
	sensor.react = (initial_state == 1)

	gpio.trig(self.pin, "both", self.switched)

	print("Initialized switch at GPIO"..self.pin.."\n")

	return self
end
