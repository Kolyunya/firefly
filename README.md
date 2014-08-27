# Firefly

## Description

Firefly is an open-source software-hardware project which is basically a night-light.

Firefly's source of light is a single [RGB](https://en.wikipedia.org/wiki/RGB_color_model) [LED](http://en.wikipedia.org/wiki/Light-emitting_diode). An LED brightness, color and state (on/off) may be altered from the remote control device.

An LED is controlled by an [Arduion Pro Mini](http://arduino.cc/en/Main/ArduinoBoardProMini) microcontroller. An Arduino is powered with an [nine-volt battery](https://en.wikipedia.org/wiki/Nine-volt_battery). An Arduino sketch is located in the `sketch` directory.

A communication with a remote control device is established over a [Bluetooth](https://en.wikipedia.org/wiki/Bluetooth) connection. A Bluetooth module used by the Firefly is [JY-MCU](http://reprap.org/wiki/Jy-mcu).

A remote control device software is written in [QML](https://en.wikipedia.org/wiki/QML) and may run on a variety of devices from moboile phones to personal computers. A remote control device software sources are stored in the `app` directory. You can use [Qt SDK](http://qt-project.org/downloads) to build and deploy it to your device of choice.

A printed circuit board scheme is stored in the `pcb` directory both in [BMP](https://en.wikipedia.org/wiki/BMP_file_format) and [Sprint-Layout](http://www.virtualworkbench.com/sprint-layout.html) formats.

## Demo

Coming soon ...