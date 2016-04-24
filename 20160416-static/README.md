[![Static Test](artwork/thumb_static.jpg?raw=true)](artwork/static.jpg?raw=true)
[![Data Acquisition Unit](artwork/thumb_adc_bottom.jpg?raw=true)](artwork/adc_bottom.jpg?raw=true)
[![Data Acquisition Unit](artwork/thumb_adc_top.jpg?raw=true)](artwork/adc_top.jpg?raw=true)


# About
Data collected from the April 16th, 2016 static test of the [Galactic Aztec Heavy] rocket (designed and built by [SDSU Rocket Project]).

Data was collected using a Raspberry Pi running custom Java based [Galactic Aztec Heavy Data Acquisition Software]. The file format is a minimalistic binary format and was converted to CSV format so that it could easily to imported into MATLAB for analysis.

Further details on the design and setup of the electronics used to collect the data can be found on the [Galactic Aztec Heavy Raspberry Pi Add-on: ADC] page.


# Data
*Below are screenshots of the graphs produced from the data collected. Note that timing of the analog and load cell data are not aligned (0 seconds elapsed for load cell corresponds to approximately 130 seconds elapsed of the analog data).*

## Analog
![Analog](analog/analog.png?raw=true)

## Load Cell
![Load Cell](loadcell/loadcell.png?raw=true)


# Sensors
Sensor    | Device
----------|-------
Analog    | [ADS1114]
Load Cell | [Phidgets Bridge]


[Galactic Aztec Heavy]: http://rocket.sdsu.edu/rockets#galactic-aztec-heavy
[SDSU Rocket Project]: http://rocket.sdsu.edu
[Galactic Aztec Heavy Data Acquisition Software]: https://github.com/twyatt/galactic-aztec-heavy-data-acquisition
[Galactic Aztec Heavy Raspberry Pi Add-on: ADC]: https://github.com/twyatt/galactic-aztec-heavy-rpi-addon-adc
[ADS1114]: http://www.ti.com/lit/ds/symlink/ads1115.pdf
[Phidgets Bridge]: http://www.phidgets.com/products.php?product_id=1046
