# wiggletron3000

ESP8266-based cat toy for lazy people. Powers a web server that controls a servo motor in several modes. Mount a feather wand like [this one](http://www.amazon.com/Luxury-Feather-Wand-Additional-Refills/dp/B00EPGZQNQ/ref=sr_1_1?ie=UTF8&qid=1455842061&sr=8-1&keywords=cat+toy+feather), a scrunchy ball at the end of monofiliment line, or whatever your cat likes, to the servo motor and your cat will go nuts. Put a webcam in front of it for added fun while at the DMV.

Client-side code in jQuery and Bootstrap. Server-side code in LUA. Feel free to rip off the general web server and servo control code for you own projects.

![Web App](http://i.imgur.com/UHqjlm4.png)

## Modes
   * The 'Position' slider lets you change the toy's position to an arbitrary value.
   * The auto buttons include:
      * 'Fast': wiggles the toy 4 times a second. My cat goes nuts.
      * 'Slow': wiggles the toy randomly once every 3 seconds. Good for getting the cat's attention.
      * 'Bottom': moves the toy to the very bottom position and turns off.
      * 'Off': moves the toy to the top position and turns off.

## Wiring it up

![Serving Suggestion](http://i.imgur.com/YnTU55n.png)

Hook up GPIO1 of your ESP-8266 to a servo (I used an SG-90) and point a browser at the IP address of the ESP-8266.

Mount a cat toy with cable ties to the axes of the servo. Make sure to test the range of the servo before mounting. You can also point an old iphone running a streaming camera server app like [Instant Webcam](http://instant-webcam.com) to enjoy the show remotely.

For ideas on building a USB programmer, flashing an ESP-8266 with NodeMCU, and basics of using the Esplorer IDE, check out [Rui Santo's guide](http://randomnerdtutorials.com/esp8266-web-server/).

Note that my multimeter says that the ESP-01 takes around 30ms while waiting for web commands. You could run the whole device on 3 AA batteries for a while.
