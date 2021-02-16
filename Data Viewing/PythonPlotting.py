# -*- coding: utf-8 -*-
"""
Created on Thu Feb  4 08:11:40 2021

@author: aadso
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

#using pandas DataFrame method

#notes: 
    #to only import certain columns of data:
    #pd.read_csv('filename', usecols = ['col1, 'col8'...])
dateString = '2021.02.16'
MDateString = dateString + ' Mary'
PipDateString = dateString + ' Pippin'
ComboDateString = dateString + ' Mary and Pippin'

MRadfilename = dateString + 'MaryRad.csv'
MAspirfilename = dateString + 'MaryAspir.csv'
MRad = pd.read_csv(MRadfilename)
MAspir = pd.read_csv(MAspirfilename)
MDatesRad = MRad[['Year', 'Month', 'Date', 'Hour', 'Minute', 'Second']]
MDatesRad.columns = ['Year', 'Month', 'Day', 'Hour', 'Minute', 'Second']
MDatesComboRad = pd.to_datetime(MDatesRad, unit = 's')#the unit = 's' is unnecessary
MTempRad = pd.Series(MRad['SHT_Amb_C'])
MTempRad.index = MDatesComboRad
MDatesAspir = MAspir[['Year', 'Month', 'Date', 'Hour', 'Minute', 'Second']]
MDatesAspir.columns = ['Year', 'Month', 'Day', 'Hour', 'Minute', 'Second']
MDatesComboAspir = pd.to_datetime(MDatesAspir, unit = 's')#the unit = 's' is unnecessary
MTempAspir = pd.Series(MAspir['SHT_Amb_C'])
MTempAspir.index = MDatesComboAspir

PipRadfilename = dateString + 'PippinRad.csv'
PipAspirfilename = dateString + 'PippinAspir.csv'
PipAspir = pd.read_csv(PipAspirfilename)
PipDatesAspir = PipAspir[['Year', 'Month', 'Date', 'Hour', 'Minute', 'Second']]
PipDatesAspir.columns = ['Year', 'Month', 'Day', 'Hour', 'Minute', 'Second']
PipDatesComboAspir = pd.to_datetime(PipDatesAspir, unit = 's')#the unit = 's' is unnecessary
PipTempAspir = pd.Series(PipAspir['SHT_Amb_C'])
PipTempAspir.index = PipDatesComboAspir
PipRad = pd.read_csv(PipRadfilename)
PipDatesRad = PipRad[['Year', 'Month', 'Date', 'Hour', 'Minute', 'Second']]
PipDatesRad.columns = ['Year', 'Month', 'Day', 'Hour', 'Minute', 'Second']
PipDatesComboRad = pd.to_datetime(PipDatesRad, unit = 's')#the unit = 's' is unnecessary
PipTempRad = pd.Series(PipRad['SHT_Amb_C'])
PipTempRad.index = PipDatesComboRad


MFan = pd.Series(MAspir['Fan_Switch'])
MFan.index = MDatesComboAspir
PipFan = pd.Series(PipAspir['Fan_Switch'])
PipFan.index = PipDatesComboAspir

MBattAspir = pd.Series(MAspir['Bat_Lvl'])
MBattAspir.index = MDatesComboAspir
MBattRad = pd.Series(MRad['Bat_Lvl'])
MBattRad.index = MDatesComboRad
PipBattAspir = pd.Series(PipAspir['Bat_Lvl'])
PipBattAspir.index = PipDatesComboAspir
PipBattRad = pd.Series(PipRad['Bat_Lvl'])
PipBattRad.index = PipDatesComboRad

MSunAspir = pd.Series(MAspir['Sunlight'])
MSunAspir.index = MDatesComboAspir
PipSunAspir = pd.Series(PipAspir['Sunlight'])
PipSunAspir.index = PipDatesComboAspir

PipSonicAspir = pd.Series(PipAspir['Sonic_Spd'])
PipSonicAspir.index = PipDatesComboAspir
MSonicAspir = pd.Series(MAspir['Sonic_Spd'])
MSonicAspir.index = MDatesComboAspir


plt.figure()
MTempAspir.plot(style = 'bx')
MTempRad.plot(xlabel = 'Date', ylabel = 'Temperature (C)', style = 'rx')
plt.legend(['Aspir', 'Rad'])
MFan.plot(secondary_y = True, style = 'k')
plt.title(MDateString + ' Temp' + ' with Fan Switch')
plt.ylabel = 'fan' #doesn't work...

plt.figure()
PipTempAspir.plot(style = 'bx')
PipTempRad.plot(xlabel = 'Date', ylabel = 'Temperature (C)', style = 'rx')
plt.legend(['Aspir', 'Rad'])
PipFan.plot(secondary_y = True, style = 'k')
plt.title(PipDateString + ' Temp' + ' with Fan Switch')
plt.ylabel = 'fan' #doesn't work...

plt.figure()
MBattAspir.plot(style = 'bx', xlabel = 'Date', ylabel = 'Voltage (V)')
MBattRad.plot(style = 'rx')
plt.legend(['Aspir', 'Rad'])
plt.title(MDateString + ' Battery Level')

plt.figure()
PipBattAspir.plot(style = 'bx', xlabel = 'Date', ylabel = 'Voltage (V)')
PipBattRad.plot(style = 'rx')
plt.legend(['Aspir', 'Rad'])
plt.title(PipDateString + ' Battery Level')

plt.figure()
MSunAspir.plot(style = 'bx', xlabel = 'Date', ylabel = 'Sunlight (W/m^2)')
PipSunAspir.plot(style = 'rx')
plt.legend(['Mary', 'Pippin'])
plt.title(ComboDateString + ' Sunlight')

plt.figure()
MSonicAspir.plot(style = 'bx')
PipSonicAspir.plot(xlabel = 'Date', ylabel = 'Sonic Speed', style = 'rx')
plt.legend(['Mary', 'Pippin'])
plt.title(ComboDateString + ' with Sonic Speed')

plt.figure()
MTempAspir.plot(style = 'bx')
MTempRad.plot(xlabel = 'Date', ylabel = 'Temperature (C)', style = 'rx')
plt.legend(['Aspir', 'Rad'])
MSunAspir.plot(secondary_y = True, style = 'g')
plt.title(MDateString + ' Temp' + ' with Sunlight')

plt.figure()
MTempAspir.plot(style = 'bx')
MTempRad.plot(xlabel = 'Date', ylabel = 'Temperature (C)', style = 'rx')
plt.legend(['Aspir', 'Rad'])
MSonicAspir.plot(secondary_y = True, style = 'g')
plt.title(MDateString + ' Temp' + ' with Sonic Speed')


