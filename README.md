# wiggletron3000

ESP8266-based cat toy for lazy people. Powers a web server that controls an SG-90 servo motor in several modes. Mount a feather wand like [this one](http://www.amazon.com/Luxury-Feather-Wand-Additional-Refills/dp/B00EPGZQNQ/ref=sr_1_1?ie=UTF8&qid=1455842061&sr=8-1&keywords=cat+toy+feather) to the servo motor and your cat will go nuts. Put a webcam in front of it for added fun while at the DMV.

![Screenshot](http://i.imgur.com/UHqjlm4.png)

## Modes:
   * The 'Position' slider lets you change the toy's position to an arbitrary value.
   * The auto buttons include:
      * 'Fast': wiggles the toy 4 times a second. My cat goes nuts.
      * 'Slow': wiggles the toy randomly once every 3 seconds. Good for getting the cat's attention.
      * 'Bottom': moves the toy to the very bottom position and turns off.
      * 'Off': moves the toy to the top position and turns off.

## Wiring it up

![Breadboard Idea](http://i.imgur.com/rMlZjCz.jpg)

Hook up GPIO1 of your ESP-8266 to a servo (I used a SG-90) and point a browser at the IP address of the ESP-8266.

Mount a cat-toy like this one with twist ties to the axes of the servo. Make sure to test the range of the servo before mounting. Here's what it can look like:

![Mounting Idea](http://i.imgur.com/knYBnSW.jpg)

<a href="http://www.youtube.com/watch?feature=player_embedded&v=https://youtu.be/yqQ89BvmUcU
" target="_blank">Here's a video of it at work.</a>

For ideas on building a USB programmer, flashing an ESP-8266 with NodeMCU, and basics of using the Esplorer IDE, check out [Rui Santo's guide](http://randomnerdtutorials.com/esp8266-web-server/).

Note that my multimeter says that the ESP-01 takes around 30ms while waiting for web commands. You could run the whole device on 3 AA batteries for a while.
