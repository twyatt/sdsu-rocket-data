[![Launch](artwork/thumb_launch.jpg?raw=true)](artwork/launch.jpg?raw=true)
[![Data Acquisition Unit](artwork/thumb_electronics.jpg?raw=true)](artwork/electronics.jpg?raw=true)

# About
Data collected from the [April 18th, 2015 launch] of the [Galactic Aztec], a 27 foot liquid propellant rocket designed and built by [SDSU Rocket Project].

The rocket flew with three data acquisition units but unfortunately data from unit #2 was lost because of the onboard fire.

Data was collected using Raspberry Pi's running custom Java based [data acquisition software]. The file format is a minimalistic binary format and was converted to CSV format so that it could easily to imported into MATLAB for analysis.

Further details on the design and setup of the electronics used to collect the data can be found on the [Galactic Aztec Raspberry Pi Add-on: Pressure Transducer Interface] page.


# Data
*Below are screenshots of the graphs produced from some of the data collected on data acquisition unit #1.*

## Accelerometer
![Accelerometer](artwork/accelerometer1.png?raw=true)

## Gyroscope
![Gyroscope](artwork/gyroscope1.png?raw=true)

## Barometer
![Barometer](artwork/barometer1.png?raw=true)

## Magnetometer
![Magnetometer](artwork/magnetometer1.png?raw=true)

## Pressures
![ADC](artwork/pressures1.png?raw=true)

Although less evident on the **Pressures** graph, the ADS1115 did not have an intuitive means of determining if an ADC read had completed (aside from watching a pin get pulled high, but that yielded lower than desirable sampling frequencies) so we would occasionally misread a data point as the wrong channel. In many cases the neighboring channel was reading in a significantly different range so these misreads could likely be easily identified and filtered appropriately.

We also suffered a failure on the readings from the pressure transducer that was reading motor chamber pressure which resulted in abnormally low and inaccurate pressure readings.


# Sensors
Sensor        | Device
--------------|-------
Accelerometer | ADXL345
Gyroscope     | ITG3205
Barometer     | MS5611
Magnetometer  | HMC5883L
GPS           | Adafruit Ultimate GPS
ADC           | Adafruit ADS1115


[April 18th, 2015 launch]: http://makezine.com/2015/07/29/meet-the-tech-and-techies-that-powered-a-high-speed-rocket/
[Galactic Aztec]: http://rocket.sdsu.edu/rockets
[SDSU Rocket Project]: http://rocket.sdsu.edu
[data acquisition software]: https://github.com/twyatt/sdsu-rocket
[Galactic Aztec Raspberry Pi Add-on: Pressure Transducer Interface]: https://github.com/twyatt/galactic-aztec-rpi-addon-pressure
