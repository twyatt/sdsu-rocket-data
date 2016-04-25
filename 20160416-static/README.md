[![Static Test](artwork/thumb_static.jpg?raw=true)](artwork/static.jpg?raw=true)
[![Data Acquisition Unit](artwork/thumb_adc_bottom.jpg?raw=true)](artwork/adc_bottom.jpg?raw=true)
[![Data Acquisition Unit](artwork/thumb_adc_top.jpg?raw=true)](artwork/adc_top.jpg?raw=true)


# About
Data collected from the April 16th, 2016 static test of the [Galactic Aztec Heavy] rocket (designed and built by [SDSU Rocket Project]).

Data was collected using a Raspberry Pi running [Galactic Aztec Heavy Data Acquisition Software]. The file format is a minimalistic binary format and was converted to CSV format so that it could be easily imported into Excel/MATLAB for analysis.

Further details on the design and setup of the electronics used to collect the data can be found on the [Galactic Aztec Heavy Raspberry Pi Add-on: ADC] page.


# Data
*Note that time elapsed of the analog and load cell data are not aligned.*

## Analog
Channel | Sensor                                   | Input (PSI) | Output (V) | Interface | Formula (```y = mx + b```)
--------|------------------------------------------|-------------|------------|-----------|---------------------------
A0      | [M3041-000005-01KPG] Pressure Transducer | 0 - 1000    | 1 - 5      | [ADS1114] | ```m = 0.25```, ```b = -250```
A1      | [M3041-000005-01KPG] Pressure Transducer | 0 - 1000    | 1 - 5      | [ADS1114] | ```m = 0.25```, ```b = -250```
A2      | [M3041-000005-05KPG] Pressure Transducer | 0 - 5000    | 1 - 5      | [ADS1114] | ```m = 1.25```, ```b = -1250```
A3      | [M3041-000005-01KPG] Pressure Transducer | 0 - 1000    | 1 - 5      | [ADS1114] | ```m = 0.25```, ```b = -250```

![Analog](analog/analog.png?raw=true)

## Load Cell
Sensor                  | Input (lb) | Output (mV/V) | Interface         | Formula (```y = mx + b```)
------------------------|------------|---------------|-------------------|---------------------------
[RL75016 WHE] Load Cell | 0 - 5000   | 0 - 3         | [Phidgets Bridge] | ```m = 1666.67```, ```b = 0```

![Load Cell](loadcell/loadcell.png?raw=true)


[Galactic Aztec Heavy]: http://rocket.sdsu.edu/rockets#galactic-aztec-heavy
[SDSU Rocket Project]: http://rocket.sdsu.edu
[Galactic Aztec Heavy Data Acquisition Software]: https://github.com/twyatt/galactic-aztec-heavy-data-acquisition
[Galactic Aztec Heavy Raspberry Pi Add-on: ADC]: https://github.com/twyatt/galactic-aztec-heavy-rpi-addon-adc
[M3041-000005-01KPG]: http://www.digikey.com/scripts/DkSearch/dksus.dll?Detail&itemSeq=195464768&uq=635971696280870285
[M3041-000005-05KPG]: http://www.digikey.com/scripts/DkSearch/dksus.dll?Detail&itemSeq=195464770&uq=635971696280870285
[ADS1114]: http://www.ti.com/lit/ds/symlink/ads1115.pdf
[RL75016 WHE]: http://www.ricelake.com/docs/prodinfo/lcg_pdf/RiceLake/double-ended/RL75016%20WHE%20Double-Ended%20Beam.pdf
[Phidgets Bridge]: http://www.phidgets.com/products.php?product_id=1046
