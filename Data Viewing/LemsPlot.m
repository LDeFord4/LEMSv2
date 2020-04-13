%% LemsPlot.m
% Nipun Gunawardena
% Plot data from a LEMSv2 File
%modified by Lexi DeFord

clear all, close all, clc

%% Command Center

%save data to worksheets for quicker access later?
saveData = false; 
saveCR3000Name = 'CR3000.10.22.19';
saveLEMS1Name = 'LEMS1.10.22.19';
saveLEMS2Name = 'LEMS2.10.22.19';


%Booleans to plot LEMS data
plot2 = true    ; % two LEMS plots? 
plotCR3000 = true; %trying to plot CR3000 data too?

plotBatt =false;
Batt_Switch_Val = 12.5; %to draw reference line on batt plot
plotTemp = true;
plotSoilT = false;
plotSoilM = false;
plotP = false;
plotWind = false;
plotSun = false;
plotSHTHum = false;


%% Get File and Data
fprintf("Select LEMS data (1)\n")
[FileName, PathName, FilterIndex] = uigetfile('~/Downloads/*.csv', 'Select the Data File');
fullFileName = strcat(PathName, FileName);
% fullFileName = '~/Downloads/LEMS/LEMSL_00.CSV';       % UncommeXnt this line and comment above two to hard code file path
%[Year,Month,Date,Hour,Minute,Second,Bat_Lvl,MLX_IR_C,MLX_Amb_C,Upper_Soil_Temp,Upper_Soil_Mois,Lower_Soil_Temp,Lower_Soil_Mois,Pressure,BMP_Amb,Wind_Dir,Wind_Spd,Sunlight,SHT_Amb_C,SHT_Hum_Pct] = importfile(fullFileName);
[Year,Month,Date,Hour,Minute,Second,Bat_Lvl,SHT_Amb_C,SHT_Hum_Pct] = importfile(fullFileName);
%% Get File and Data 2
if plot2
    fprintf("Select LEMS data (2)\n")
    [FileName2, PathName2, FilterIndex2] = uigetfile('~/Downloads/*.csv', 'Select the Data File');
    fullFileName2 = strcat(PathName2, FileName2);
    % fullFileName = '~/Downloads/LEMS/LEMSL_00.CSV';       % UncommeXnt this line and comment above two to hard code file path
    %[Year2,Month2,Date2,Hour2,Minute2,Second2,Bat_Lvl2,MLX_IR_C2,MLX_Amb_C2,Upper_Soil_Temp2,Upper_Soil_Mois2,Lower_Soil_Temp2,Lower_Soil_Mois2,Pressure2,BMP_Amb2,Wind_Dir2,Wind_Spd2,Sunlight2,SHT_Amb_C2,SHT_Hum_Pct2] = importfile(fullFileName2);
    [Year2,Month2,Date2,Hour2,Minute2,Second2,Bat_Lvl2,SHT_Amb_C2,SHT_Hum_Pct2] = importfile(fullFileName2);
end
%% Get File and Data 3, CR3000
if plotCR3000
    fprintf("Select CR3000 data\n")
    [FileName3, PathName3, FilterIndex3] = uigetfile('~/Downloads/*.csv', 'Select the Data File');
    fullFileName3 = strcat(PathName3, FileName3);
    % fullFileName = '~/Downloads/LEMS/LEMSL_00.CSV';       % UncommeXnt this line and comment above two to hard code file path
    [CR3000_Time,Record3,PTemp_C,TT_C] = dataImport(true, fullFileName3);%make sure this matches the data file!
    %[CR3000_Time,PTemp_C,TT_C] = dataImport(true, fullFileName3);%make sure this matches the data file!
    %[~,Record3,Batt_Lvl3,PTemp_C,TT_C, SBT_C] = importfile(fullFileName3);
end
%% Get Dates
dates = datenum(Year, Month, Date, Hour, Minute, Second);
date_plot=(datetime(datevec(dates)));
%using decimate on dates does not work, turns data into times in 1996


if plot2
    dates2 = datenum(Year2, Month2, Date2, Hour2, Minute2, Second2);
    date_plot2=(datetime(datevec(dates2)));
end
if plotCR3000
    date_plot3 = datetime(datevec(CR3000_Time));
end
% %% Saving Data to workspace
% if saveData
%     save(saveCR3000Name, 'date_plot3','Record3','Batt_Lvl3','PTemp_C','TT_C', 'SBT_C');
%     save(saveLEMS1Name, 'date_plot', 'Bat_Lvl','MLX_IR_C','MLX_Amb_C');
% end



%% Plot Battery
if plotBatt
    figure()
    hold on
    plot(date_plot, Bat_Lvl);
    plot(date_plot(1:length(Bat_Lvl2)), Bat_Lvl2);
    yref = zeros(1, length(date_plot));
    yref(1,:) = Batt_Switch_Val;
    plot(date_plot, yref)
    legend('SHT Radiation Shield', 'SHT Fan');
    xlabel('Date');
    ylabel('Battery Level (Volts)');
    title('Battery Voltage');
end


%% Plot Temperature
if plotTemp
    figure()
    hold all
    %plot(date_plot, BMP_Amb);
    %plot(date_plot, MLX_Amb_C, 'bx');
%     date_plot = date_plot(1:length(date_plot2));
%     SHT_Amb_C = SHT_Amb_C(1:length(SHT_Amb_C2));
    plot(date_plot2(1:length(SHT_Amb_C)), SHT_Amb_C, 'bx');
%     date_plot2 = date_plot(1:length(date_plot2));
%     SHT_Amb_C2 = SHT_Amb_C2(1:length(SHT_Amb_C2));
    %plot(date_plot, MLX_IR_C, 'bx');
    %plot(date_plot, SHT_Amb_C);
    if plot2
    %plot(date_plot2, BMP_Amb2);
    %plot(date_plot2, MLX_Amb_C2, 'rx');
    plot(date_plot2(1:length(SHT_Amb_C2)), SHT_Amb_C2, 'rx');
    %dateplot = date_plot(1:end-2);
    %plot(date_plot2, MLX_IR_C2, 'rx');
    %plot(date_plot2, SHT_Amb_C2);
    end
    if plotCR3000
%         dateplot3 = date_plot3(93640:end);
%         PTempC = PTemp_C(93640:end);
   %date_plot3 = date_plot3(1):seconds(10):date_plot(end); %for when the csv file does not 
    %have seconds but the data was taken every ten seconds
   date_plot3 = date_plot3(1:length(TT_C));
    %TT_C = TT_C(1:length(date_plot3));
    plot(date_plot3, TT_C, 'kx');
    %plot(date_plot3, TT_C);
    %plot(date_plot3, SBT_C); 
    end

    xlabel('Date');
    ylabel('Temperature (Celsius)');
    title('Air Temperature with and without Fan');
    legend('SHT Radiation Shield', 'SHT Fan', 'Finewire');
        %'PTemp', 'TT', 'SBT');
    %legend('MLX Surface1', 'MLX Surface2',...
        %'PTemp', 'TT', 'SBT');
%     LemsAnalysis(SHT_Amb_C,date_plot, SHT_Amb_C2,date_plot2, TT_C, date_plot3)
end

%% Plot Soil Moisture
if plotSoilM
    figure()
    hold all
    plot(dates, Lower_Soil_Mois);
    plot(dates, Upper_Soil_Mois);
    xlabel('Date');
    ylabel('Soil Moisture (m^3/m^3)');
    title('Soil Moisture');
    legend('Lower Sensor', 'Upper Sensor');
end

%% Plot Soil Temperature
if plotSoilT
    figure()
    hold all
    plot(dates, Lower_Soil_Temp);
    plot(dates, Upper_Soil_Temp);
    xlabel('Date');
    ylabel('Soil Temperature (Celsius)');
    title('Soil Temperature');
    legend('Lower Sensor', 'Upper Sensor');
end


%% Plot Pressure
if plotP
    figure()
    plot(dates, Pressure);
    xlabel('Date');
    ylabel('Pressure (Pascals)');
    title('Barometric Pressure');
end

%% Humidity
if plotSHTHum
    figure()
    plot(dates, SHT_Hum_Pct);
    xlabel('Date');
    ylabel('Relative Humidity (%RH)');
    title('Relative Humidity');
end

%% Sunlight
if plotSun
    figure()
    plot(dates, Sunlight);
    xlabel('Date');
    ylabel('Incoming Shortwave Radiation (W/m^2)');
    title('Incoming Solar Radiation');
end

%% Wind Direction/Spd
if plotWind
    figure()
    subplot(2,1,1);
    plot(dates, Wind_Dir);
    xlabel('Date');
    ylabel('Wind Direction (Degrees from North)');
    title('Wind Direction');

    subplot(2,1,2);
    plot(dates, Wind_Spd);
    xlabel('Date');
    ylabel('Wind Speed (m/s)');
    title('Wind Speed');
end
