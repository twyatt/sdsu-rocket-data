[![Launch](artwork/thumb_static.jpg?raw=true)](artwork/static.jpg?raw=true)
[![Data Acquisition Unit](artwork/thumb_electronics.jpg?raw=true)](artwork/electronics.jpg?raw=true)


# About
Data collected from the [April 16th, 2016 static test] of the [Galactic Aztec Heavy] rocket (designed and built by [SDSU Rocket Project]).

Data was collected using a Raspberry Pi running custom Java based [data acquisition software]. The file format is a minimalistic binary format and was converted to CSV format so that it could easily to imported into MATLAB for analysis.

Further details on the design and setup of the electronics used to collect the data can be found on the [Galactic Aztec Raspberry Pi Add-on: Pressure Transducer Interface] page.


# Data
*Below are screenshots of the graphs produced from the data collected.*

## Analog
![Analog](analog/analog.png?raw=true)

## Load Cell
![Load Cell](loadcell/loadcell.png?raw=true)


# Sensors
Sensor    | Device
----------|-------
Analog    | ADS1114
Load Cell | Phidgets Bridge


[April 18th, 2015 launch]: http://makezine.com/2015/07/29/meet-the-tech-and-techies-that-powered-a-high-speed-rocket/
[Galactic Aztec]: http://rocket.sdsu.edu/rockets
[SDSU Rocket Project]: http://rocket.sdsu.edu
[data acquisition software]: https://github.com/twyatt/sdsu-rocket
[Galactic Aztec Raspberry Pi Add-on: Pressure Transducer Interface]: https://github.com/twyatt/galactic-aztec-rpi-addon-pressure
