-- Jack up the UART baud rate for faster subsequent uploads
-- You'll have to talk to the ESP8266 at 115200 after the first run of this file
uart.setup(0,115200,8,0,1,1,1)

-- Global constants
position_change_ms_fast = 250 -- How fast to wiggle in fast mode
position_change_ms_slow = 3000 -- How fast to wiggle in slow mode
blink_ms = 100 -- not used
wifi_ap="Bro Fortress"
wifi_password="" -- Replace this with your password

-- You need to upload and save these files to your ESP8266 independently
dofile("servo.lua")
dofile("httpserver.lua")
dofile("misc.lua")

-- This one too
index_html = read_file("webpage.html")

connect_wifi(wifi_ap, wifi_password)