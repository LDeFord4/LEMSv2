%% LemsPlot.m
% Nipun Gunawardena
% Plot data from a LEMSv2 File
%modified by Lexi DeFord

clear, close all, clc

%% Command Center

%Booleans to plot LEMS data
plot2 = false; % exactly two LEMS plots? 
plot4 = true; % exactly four LEMS plots?
plotCR3000 = false; %trying to plot CR3000 data too?

plotBatt = false;
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
[FileName, PathName, FilterIndex] = uigetfile('~/Desktop/*.csv', 'Select the Data File');
fullFileName = strcat(PathName, FileName);
% fullFileName = '~/Downloads/LEMS/LEMSL_00.CSV';       % UncommeXnt this line and comment above two to hard code file path
%[Year,Month,Date,Hour,Minute,Second,Bat_Lvl,MLX_IR_C,MLX_Amb_C,Upper_Soil_Temp,Upper_Soil_Mois,Lower_Soil_Temp,Lower_Soil_Mois,Pressure,BMP_Amb,Wind_Dir,Wind_Spd,Sunlight,SHT_Amb_C,SHT_Hum_Pct] = importfile(fullFileName);
[Year,Month,Date,Hour,Minute,Second,Bat_Lvl,SHT_Amb_C,SHT_Hum_Pct] = importfile(fullFileName);
%% Get File and Data 2
if plot2
    fprintf("Select LEMS data (2)\n")
    [FileName2, PathName2, FilterIndex2] = uigetfile('~/Desktop/*.csv', 'Select the Data File');
    fullFileName2 = strcat(PathName2, FileName2);
    % fullFileName = '~/Downloads/LEMS/LEMSL_00.CSV';       % UncommeXnt this line and comment above two to hard code file path
    %[Year2,Month2,Date2,Hour2,Minute2,Second2,Bat_Lvl2,MLX_IR_C2,MLX_Amb_C2,Upper_Soil_Temp2,Upper_Soil_Mois2,Lower_Soil_Temp2,Lower_Soil_Mois2,Pressure2,BMP_Amb2,Wind_Dir2,Wind_Spd2,Sunlight2,SHT_Amb_C2,SHT_Hum_Pct2] = importfile(fullFileName2);
    [Year2,Month2,Date2,Hour2,Minute2,Second2,Bat_Lvl2,SHT_Amb_C2,SHT_Hum_Pct2] = importfile(fullFileName2);
end
%% Get File and Data 3, CR3000
if plotCR3000
    fprintf("Select CR3000 data\n")
    [FileName3, PathName3, FilterIndex3] = uigetfile('~/Desktop/*.csv', 'Select the Data File');
    fullFileName3 = strcat(PathName3, FileName3);
    % fullFileName = '~/Downloads/LEMS/LEMSL_00.CSV';       % UncommeXnt this line and comment above two to hard code file path
    [CR3000_Time,Record3,BattV,PTemp_C,TT_C, RH] = dataImport(true, fullFileName3);%make sure this matches the data file!
    %[CR3000_Time,PTemp_C,TT_C] = dataImport(true, fullFileName3);%make sure this matches the data file!
    %[~,Record3,Batt_Lvl3,PTemp_C,TT_C, SBT_C] = importfile(fullFileName3);
end

%% Get File and Date, 4 LEMS
if plot4
    fprintf("Select LEMS data (2) (Aspir Pippin)\n")
    [FileName2, PathName2, FilterIndex2] = uigetfile('~/Downloads/*.csv', 'Select the Data File');
    fullFileName2 = strcat(PathName2, FileName2);
    [Year2,Month2,Date2,Hour2,Minute2,Second2,Bat_Lvl2,SHT_Amb_C2,SHT_Hum_Pct2] = importfile(fullFileName2);
    dates2 = datenum(Year2, Month2, Date2, Hour2, Minute2, Second2);
    date_plot2 =(datetime(datevec(dates2)));

    fprintf("Select LEMS data (Rad Mary)(3)\n")
    [FileName3, PathName3, FilterIndex3] = uigetfile('~/Downloads/*.csv', 'Select the Data File');
    fullFileName3 = strcat(PathName3, FileName3);
    [Year3,Month3,Date3,Hour3,Minute3,Second3,Bat_Lvl3,SHT_Amb_C3,SHT_Hum_Pct3] = importfile(fullFileName3);
    dates3 = datenum(Year3, Month3, Date3, Hour3, Minute3, Second3);
    date_plot3 =(datetime(datevec(dates3)));

    fprintf("Select LEMS data (Aspir Mary)(4)\n")
    [FileName4, PathName4, FilterIndex4] = uigetfile('~/Downloads/*.csv', 'Select the Data File');
    fullFileName4 = strcat(PathName4, FileName4);
    [Year4,Month4,Date4,Hour4,Minute4,Second4,Bat_Lvl4,SHT_Amb_C4,SHT_Hum_Pct4] = importfile(fullFileName4);
    dates4 = datenum(Year4, Month4, Date4, Hour4, Minute4, Second4);
    date_plot4 =(datetime(datevec(dates4)));
end
%% Get Dates
dates = datenum(Year, Month, Date, Hour, Minute, Second);
date_plot=(datetime(datevec(dates)));

if plot2
    dates2 = datenum(Year2, Month2, Date2, Hour2, Minute2, Second2);
    date_plot2=(datetime(datevec(dates2)));
end
if plotCR3000
    date_plot3 = datetime(datevec(CR3000_Time));
end
if plot4
    dates2 = datenum(Year2, Month2, Date2, Hour2, Minute2, Second2);
    date_plot2=(datetime(datevec(dates2)));
    dates3 = datenum(Year3, Month3, Date3, Hour3, Minute3, Second3);
    date_plot3=(datetime(datevec(dates3)));
    dates4 = datenum(Year4, Month4, Date4, Hour4, Minute4, Second4);
    date_plot4=(datetime(datevec(dates4)));
end
%% Fix/Link Date vectors

if plot2
    if length(date_plot) < length(date_plot2)
        %if date_plot is shorter than date_plot2, we need to use the shorter
        % date_plot for graphing
        date_plot_use = date_plot;
        %then we need to shorten date_plot2's data
        date_plot2 = date_plot2(1:length(date_plot));
        SHT_Amb_C2 = SHT_Amb_C2(1:length(date_plot));
        Bat_Lvl2 = Bat_Lvl2(1:length(date_plot));
    else
        date_plot_use = date_plot2;
        %then we need to shorten date_plot's data
        date_plot = date_plot(1:length(date_plot2));
        SHT_Amb_C = SHT_Amb_C(1:length(date_plot2));
        Bat_Lvl = Bat_Lvl(1:length(date_plot2));
    end
end
if plotCR3000
    if (length(date_plot) < length(date_plot2)) && (length(date_plot) < length(date_plot3))
        date_plot_use = date_plot;
    end
    if (length(date_plot2) < length(date_plot)) && (length(date_plot2) < length(date_plot3))
        date_plot_use = date_plot2;
    end
    if (length(date_plot3) < length(date_plot2)) && (length(date_plot3) < length(date_plot))
        date_plot_use = date_plot3;
    end
end
if plot4
    if length(date_plot) < length(date_plot2)
        %if date_plot is shorter than date_plot2, we need to use the shorter
        % date_plot for graphing
        date_plot_use = date_plot;
        %then we need to shorten date_plot2's data
        date_plot2 = date_plot2(1:length(date_plot));
        SHT_Amb_C2 = SHT_Amb_C2(1:length(date_plot));
        Bat_Lvl2 = Bat_Lvl2(1:length(date_plot));
    else
        date_plot_use = date_plot2;
        %then we need to shorten date_plot's data
        date_plot = date_plot(1:length(date_plot2));
        SHT_Amb_C = SHT_Amb_C(1:length(date_plot2));
        Bat_Lvl = Bat_Lvl(1:length(date_plot2));
    end
    if length(date_plot3) < length(date_plot4)
        %if date_plot is shorter than date_plot2, we need to use the shorter
        % date_plot for graphing
        date_plot_use = date_plot3;
        %then we need to shorten date_plot2's data
        date_plot4 = date_plot4(1:length(date_plot3));
        SHT_Amb_C4 = SHT_Amb_C4(1:length(date_plot3));
        Bat_Lvl4 = Bat_Lvl4(1:length(date_plot3));
    else
        date_plot_use = date_plot4;
        %then we need to shorten date_plot's data
        date_plot3 = date_plot3(1:length(date_plot4));
        SHT_Amb_C3 = SHT_Amb_C3(1:length(date_plot4));
        Bat_Lvl3 = Bat_Lvl3(1:length(date_plot4));
    end
end
%% Plot Battery
if plotBatt
    figure()
    hold on
    plot(date_plot2, Bat_Lvl);
    plot(date_plot2, Bat_Lvl2);
    yref = zeros(1, length(date_plot2));
    yref(1,:) = Batt_Switch_Val;
    plot(date_plot2, yref)
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
      plot(date_plot2, SHT_Amb_C, 'bx');
%     date_plot2 = date_plot(1:length(date_plot2));
%     SHT_Amb_C2 = SHT_Amb_C2(1:length(SHT_Amb_C2));
    %plot(date_plot, MLX_IR_C, 'bx');
    %plot(date_plot, SHT_Amb_C);
    if plot2
    %plot(date_plot2, BMP_Amb2);
    %plot(date_plot2, MLX_Amb_C2, 'rx');
    plot(date_plot2, SHT_Amb_C2, 'rx');
    %dateplot = date_plot(1:end-2);
    %plot(date_plot2, MLX_IR_C2, 'rx');
    %plot(date_plot2, SHT_Amb_C2);
    end
    if plot4
        plot(date_plot2, SHT_Amb_C2, 'rx');
        plot(date_plot4, SHT_Amb_C3, 'gx');
        plot(date_plot4, SHT_Amb_C4, 'yx');
        legend('Rad Pippin', 'Aspir Pippin', 'Rad Mary', 'Aspir Mary')
    end
    if plotCR3000
%         dateplot3 = date_plot3(93640:end);
%         PTempC = PTemp_C(93640:end);
   %date_plot3 = date_plot3(1):seconds(10):date_plot(end); %for when the csv file does not 
    %have seconds but the data was taken every ten seconds
   date_plot3 = date_plot3(1:length(TT_C));
    %TT_C = TT_C(1:length(date_plot3));
    plot(date_plot3, TT_C, 'kx');
    plot(date_plot3, PTemp_C, 'yx');
    legend('Rad', 'Aspir', 'TT_C', 'panel T')
    %plot(date_plot3, TT_C);
    %plot(date_plot3, SBT_C); 
    end

    xlabel('Date');
    ylabel('Temperature (Celsius)');
    title('Air Temperature with and without Fan');
%     legend('SHT Radiation Shield', 'SHT Fan', 'Finewire');
        %'PTemp', 'TT', 'SBT');
    %legend('MLX Surface1', 'MLX Surface2',...
        %'PTemp', 'TT', 'SBT');
     %LemsAnalysis(SHT_Amb_C,date_plot, SHT_Amb_C2, date_plot2, 1,1)
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
