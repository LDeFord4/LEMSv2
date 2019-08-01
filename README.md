# LEMSv2
This is the repository for the second version of the LEMS Sensor Stations. Stay tuned, information will be added as it is generated. A majority of the documentation will be added to this file.

Note that a peer-reviewed description of LEMSv1 may be found here: https://iopscience.iop.org/article/10.1088/1361-6501/aa97fb


### General TODO

1. Check validity of filenames with more than 8 characters
2. Decagon, the manufacturer of the 5TM soil sensors, has changed their name to Meter, and the 5TM is now called the ECH20 5TM. The DS2 is now called the Atmos 22. The documentation will need to be changed and will probably be done slowly.
3. Major Change: Change the code to read parameters from a text file on the SD card. See if possible to read code from SD card.
4. Delete or separate "File List" from README? Makes it clunky, hard to keep updated. Goal is for files to self explanatory 
5. Update DS2 code to use EnviroDIY's SDI12 library instead of custom library

### PCB TODO
1. Change the parts in the eagle files for BOM lines 11, 29, 30. These parts were out of stock and were replaced by different parts during manufacturing.



### File List
* Code/
  * `Code Instructions.md` - Instructions for uploading
  * LEMSv2/
    * `LEMSv2.ino` - LEMS Arduino Code
    * `DS3231_Alarm1.h` - Header file for corresponding `.cpp` file
    * `DS3231_Alarm1.cpp` - File used to set DS3231 Alarm 1. Developed in test code then copied to this folder
    * `d5TM.h` - Header file for corresponding `.cpp` file
    * `d5TM.cpp` - Library used to interact with 5TM. Developed in test code then copied to this folder
  * Test Code/
    * ADS1115_Test/
      * `ADS1115_Test.ino` - Test code for ADS1115 ADC
    * DS3231_Test/
      * `DS3231_Test.ino` - Test code for DS3231 RTC. Test DS3231 alarm 1
      * `DS3231_Alarm1.h` - Header file for corresponding `.cpp` file
      * `DS3231_Alarm1.c` - Library used to set DS3231 Alarm 1. Developed in here then copied to main code folder
    * DS2_Test/
      * `DS2_Test.ino` - Test code for DS2 anemometer
      * `DS2.h` - Header file for corresponding `.cpp` file
      * `DS2.cpp` - Library used to interact with DS2. Developed here then copied to main code folder
      * `LICENSE` - License to be included with the `SDI12_Zero` library
      * `LICENSE-examples.md` - License to be included with the `SDI12_Zero` library
      * `SDI12_Zero.h` - Header file for corresponding `.cpp` file
      * `SDI12_Zero.cpp` - Library used by DS2 library to interact with DS2. Implements the SDI12 protocal for Arduino Zero.
    * Li200_Test/
      * `Li200_Test.ino` - Test Li200 with intermediate values in calculations printed
    * Teros21_Test/
      * `Teros21_Test.ino` - Test Teros21 and library.
    * Test_5TM/
      * `Test_5TM.ino` - Test code for 5TM Library. 5TM has been working since LEMSv1 but is now made into a library.
      * `d5TM.h` - Header file for corresponding `.cpp` file
      * `d5TM.cpp` - Library used to interact with 5TM. Developed here then copied to main code folder
  * Time_Set/
    * `Time_Set.ino` - Code used to set the time on the DS3231 real time clock
* Data Manipulation/
  * `LemsPlot.m` - View LEMSv2 data plots. Not perfectly adaptable to any file, but will work for a fully instrumented station. To work properly, requires the [Intelligent Dynamic Date Ticks](https://www.mathworks.com/matlabcentral/fileexchange/27075-intelligent-dynamic-date-ticks) file from MathWorks. Can work without it though by commenting out the lines that use it.
  * `importfile.m` - Used to import the LEMSv2 data files. Can only be used on data files from fully instrumented LEMS.
* Hardware Information/
  * `Bill of Materials.xlsx` - Complete parts list
  * `Calibration Constants.xlsx` - Calibration constants for various instruments. For now, only contains Li200 constants.
  * Data Sheets/
    * Multiple data sheets for components
  * Li200R Base/
    * Solidworks/
      * Contains Solidworks files for Li200R base
    * STL Files/
      * Contains print ready STL files for Li200R base
    * `Build Instructions.md` - Tools required for making the Li200R base
  * MLX Housing/
    * `MLX Housing Build Instructions` - Build instructions for MLX90615 housing
  * PCB/
    * `LEMSv2 Board.pdf` - PDF of PCB for easy reference
    * `LEMSv2 Schematic.pdf` - PDF of schematic for easy reference
    * `SAMD21 Breakout Board.jpg` - Reference picture for microcontroller board
  * `Pin List.xlsx` - Pin connection list for SAMD21 Dev Breakout Board
  * `Possible Parts.txt` - Potential parts/Manufacturers to add/use in the future
  * Transimpedance Amplifier/
    * `Transimpedance_Amplifier_Calculations.ipynb` - Jupyter notebook containing transimpedance amplifier calculations
  * `Wiring Information.xlsx` - Information about wiring. What connects to what, etc. Work in progress.
* `LICENSE.TXT` - License
* PCB/
  * LEMSv2 PCB/
    * `Centroid_ScreamingCircuits_smd.ulp` - Eagle ULP script to create centroid data for screaming circuits
    * Gerbers/
      * Contains gerbers for board, plus the panelized gerbers supplied by OSH Park. Also contains the centroid file for Screaming Circuits.
    * `LEMSv2.sch` - LEMSv2 shield schematic
    * `LEMSv2.brd` - LEMSv2 shield layout
    * `OSH_DesignRules.dru` - Eagle design rules for OSH Park
    * `OSHPark_2layer_Eagle7.2.cam` - Modified cam job for OSH Park
  * LEMSv2 PCB Library/
    * `LEMSv2.lbr` - Parts used in the LEMSv2 shield
* `Possible Problems.md` - List of potential hardware problems in the LEMS. Prefer to not have duplicate entries, i.e. one line per problem.
* `README.md` - If you read this line you're actually reading the README. Good job!



### Dependencies
Only 3rd party software dependencies are included in this list. Libraries built into the Arduino software or created for the LEMSv2 software isn't included. You will need the most recent version of the [Arduino IDE](https://www.arduino.cc/en/Main/Software) installed.

* [Adafruit RTC Library](https://github.com/adafruit/RTClib)
* [Adafruit SHT31 Library](https://github.com/adafruit/Adafruit_SHT31)
* [Adafruit Sensor Library](https://github.com/adafruit/Adafruit_Sensor)
* [Adafruit BMP280 Library](https://github.com/adafruit/Adafruit_BMP280_Library)
* [Adafruit MLX90614 Library](https://github.com/adafruit/Adafruit-MLX90614-Library)
* [EnviroDIY SDI-12 Library](https://github.com/EnviroDIY/Arduino-SDI-12) 
* [Soligen2010's fork of the Adafruit ADS1x15 Library](https://github.com/soligen2010/Adafruit_ADS1X15). The default Adafruit ADS1x15 library **doesn't** work.
* In addition, the Sparkfun SAMD21 [board definition](https://raw.githubusercontent.com/sparkfun/Arduino_Boards/master/IDE_Board_Manager/package_sparkfun_index.json
  ) needs to be installed into the Arduino IDE. See [here](https://learn.sparkfun.com/tutorials/samd21-minidev-breakout-hookup-guide/setting-up-arduino) for more info.

### Miscellaneous Notes

- ADS1115 single ended resolution calculation information can be found [here](https://e2e.ti.com/support/data_converters/precision_data_converters/f/73/t/489070)
- ADS1115 over range input information can be found [here](https://e2e.ti.com/support/data_converters/precision_data_converters/f/73/p/398187/1407689#1407689) and [here](https://e2e.ti.com/support/data_converters/precision_data_converters/f/73/t/378122)

### Acknowledgements

* Thanks to [Sparkfun](https://www.sparkfun.com) and [Adafruit](https://www.adafruit.com) for Arduino libraries, components, tutorials, and eagle parts. Many designs and eagle components are directly used from them. Also thanks to [OSH Park](www.oshpark.com) and [Screaming Circuits](www.screamingcircuits.com) for the excellent PCBs and assembly. They were instrumental in getting LEMSv2 completed.
