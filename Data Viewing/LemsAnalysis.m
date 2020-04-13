%LemsAnalysis
%Lexi DeFord
%3.2.20

function [] = LemsAnalysis(Rad_Data,Rad_date_plot, Aspir_Data, Aspir_date_plot, FW_Data, FW_date_plot)
%LemsAnalysis takes in six sets of data: three pairs of Data and Dates
%associated with that data collection.  Then this function analyzes these,
%finding statistical values like standard deviation and mean difference,
%returning plots with these values on them and graphs of the data being
%compared.

%
if length(Rad_date_plot) >= length(Aspir_date_plot)
    date_plotRadAspir = Rad_date_plot(1:length(Aspir_date_plot));
    Rad_Data = Rad_Data(1:length(Aspir_Data));
    fprintf("Using Rad_date_plot\n")
else
    date_plotRadAspir = Aspir_date_plot(1:length(Rad_date_plot));
    Aspir_Data = Aspir_Data(1:length(Rad_Data));
    fprintf("Using Aspir_date_plot\n")
end

stats1 = fitlm(Rad_Data, Aspir_Data);
% 
FW_DataTog = FW_Data(1:end);
Aspir_DataTog = Aspir_Data(1:length(FW_DataTog));

% Aspir_DataTog = Aspir_Data(1:end);  %can implement same tech as above with rad and aspir here
% FW_DataTog = FW_Data(1:length(Aspir_DataTog));

stats2 = fitlm(FW_DataTog, Aspir_DataTog);

%for 3.04.20 data, used 2200, then 2099
%for 3.05.20 (1), 18Deg, used 134
%for 3.05.20 (2), 32Deg, used 201
%for 3.06.20, 55Deg, used 1499
%for 3.18.20Inside, baseline, used 12951
%for 3.21.20, (1), 42Deg, used 82
%for 3.21.20, (2), 75Deg, used 54
timeStrt = 134; %%Need to change per data collection

date_plotShort = date_plotRadAspir(timeStrt:(timeStrt+360));
Rad_Data_Short = Rad_Data(timeStrt:(timeStrt+360)); 
Aspir_Data_Short = Aspir_Data(timeStrt:(timeStrt+360));

stats3 = fitlm(Rad_Data_Short, Aspir_Data_Short);


%used 433 for 3.04.20, in minutes!!!!, then 380 
%for 3.05.20 (1), 18Deg, used 133 after make own date_plot3 in LemsPlot
%for 3.05.20 (2), 32Deg, used 277 after make own date_plot3 in LemsPlot
%for 3.06.20, 55Deg, used 2593 after make own date_plot3 in LemsPlot
%for 3.21.20 (1), 42Deg, used 82 (yes, is same for timeStrt)
%for 3.21.20 (2), 75Deg, used 54 (yes, is same for timeStrt)
%though, now that I think about it, I really need to specifiy on what
%second count I start that datetime vector too..
timeStrtFW = 133; %% need to change per data collection
%want 1 hour of data, so is FW taking data every min or 10 sec?

FW_date_plot_Short = FW_date_plot(timeStrtFW:(timeStrtFW+360));
FW_Data_Short = FW_Data(timeStrtFW:(timeStrtFW+360));
%Rad_Data_Short_Min = Rad_Data(timeStrt:6:(timeStrt+360));
Rad_Data_Short_Min = Rad_Data(timeStrt:(timeStrt+360)); 
%Aspir_Data_Short_Min = Aspir_Data(timeStrt:6:(timeStrt+360));
Aspir_Data_Short_Min = Aspir_Data(timeStrt:(timeStrt+360));

stats4 = fitlm(FW_Data_Short, Aspir_Data_Short_Min);

stats5 = fitlm(FW_Data_Short, Rad_Data_Short_Min);

% Mon = num2str(date_plotRadAspir(end).Month);
% Day = num2str(date_plotRadAspir(end).Day);
% Ye  = num2str(date_plotRadAspir(end).Year);
Mon = num2str(Aspir_date_plot(end).Month);
Day = num2str(Aspir_date_plot(end).Day);
Ye  = num2str(Aspir_date_plot(end).Year);
dateStr = [Mon, '.', Day, '.', Ye]; %date of Data Collection

mean(Rad_Data_Short)
mean(Aspir_Data_Short)
mean(Aspir_Data_Short_Min)
mean(FW_Data_Short)


%% Statistics of Rad and Aspir (two SHTs) (in total)
figure
hold on
plot(Rad_Data, Aspir_Data, 'b*')
refline(1, 0)
title({dateStr;'V2 Aspirated Sensor vs. Radiation Shield (in total)'})
xlabel('Rad (\circ C)')
ylabel('V2 (\circ C)')
R2Str = num2str(stats1.Rsquared.ordinary);
R2Text = ['R^2 value is ', R2Str];
AvgStr = mean(Aspir_Data-Rad_Data);
AvgText = ['Mean Difference is ', num2str(AvgStr)];
SdC = std(Rad_Data);
SdC2 = std(Aspir_Data);
SdCText = ['Standard Deviation of Data 1: ', num2str(SdC)];
SdC2Text = ['Standard Deviation of Data 2: ', num2str(SdC2)];
SdAvgText = ['Difference between Standard Deviations is ',num2str(SdC-SdC2)];
annotation('textbox',[.15 .55 .35 .35], 'String', {R2Text;AvgText;SdCText;SdC2Text;SdAvgText});
hold off

%% Statistics of V2 and Finewire (in total)
figure
hold on
plot(FW_DataTog, Aspir_DataTog, 'b*')
refline(1, 0)
title({dateStr;'V2 vs Finewire (in total)'})
xlabel('Finewire (\circ C)')
ylabel('V2 (\circ C)')
R2Str = num2str(stats2.Rsquared.ordinary);
R2Text = ['R^2 value is ', R2Str];
AvgStr = mean(Aspir_DataTog - FW_DataTog);
AvgText = ['Mean Difference is ', num2str(AvgStr)];
SdTTCfw = std(FW_DataTog);
SdC2fw = std(Aspir_DataTog);
SdTTCText = ['Standard Deviation of Finewire: ', num2str(SdTTCfw)];
SdC2Text = ['Standard Deviation of V2: ', num2str(SdC2fw)];
SdAvgText = ['Difference between Standard Deviations is ',num2str(SdTTCfw-SdC2fw)];
annotation('textbox',[.4 .1 .5 .3], 'String', {R2Text;AvgText;SdTTCText;SdC2Text;SdAvgText});
hold off

%% Statistics of Rad and Aspir (two SHTs) (in short)
figure
hold on
plot(Rad_Data_Short_Min, Aspir_Data_Short_Min, 'b*')
refline(1, 0)
title({dateStr;'V2 Aspirated Sensor vs. Radiation Shield, over 1 hour'})
xlabel('Rad (\circ C)')
ylabel('V2 (\circ C)')
R2Str = num2str(stats3.Rsquared.ordinary);
R2Text = ['R^2 value is ', R2Str];
AvgStr = mean(Aspir_Data_Short-Rad_Data_Short);
AvgText = ['Mean Difference is ', num2str(AvgStr)];
SdC = std(Rad_Data_Short);
SdC2 = std(Aspir_Data_Short);
SdCText = ['Standard Deviation of Rad: ', num2str(SdC)];
SdC2Text = ['Standard Deviation of V2: ', num2str(SdC2)];
SdAvgText = ['Difference between Standard Deviations is ',num2str(SdC2-SdC)];
annotation('textbox',[.15 .55 .35 .35], 'String', {R2Text;AvgText;SdCText;SdC2Text;SdAvgText});
hold off

%% Statistics of Aspir and FineWire (in short)

figure
hold on
plot(FW_Data_Short, Aspir_Data_Short_Min, 'b*')
refline(1, 0)
title({dateStr;'V2 Aspirated Sensor vs. Finewire, over 1 hour'})
xlabel('Firewire (\circ C)')
ylabel('V2 (\circ C)')
R2Str = num2str(stats4.Rsquared.ordinary);
R2Text = ['R^2 value is ', R2Str];
AvgStr = mean(Aspir_Data_Short_Min-FW_Data_Short);
AvgText = ['Mean Difference is ', num2str(AvgStr)];
SdFWDataShort = std(FW_Data_Short);
SdC2fw = std(Aspir_Data_Short_Min);
SdCfwText = ['Standard Deviation of Finewire: ', num2str(SdFWDataShort)];
SdC2fwText = ['Standard Deviation of V2: ', num2str(SdC2fw)];
SdAvgfwText = ['Difference between Standard Deviations is ',num2str(SdC2fw-SdFWDataShort)];
annotation('textbox',[.4 .1 .5 .3], 'String', {R2Text;AvgText;SdCfwText;SdC2fwText;SdAvgfwText});
hold off

%% Statistics of Aspir & Rad and FineWire (in short)

figure
hold on
plot(FW_Data_Short, Aspir_Data_Short_Min, 'b*')
p = plot(FW_Data_Short, Rad_Data_Short_Min, 'r*');
p(1).Color = [0.8500 0.3250 0.0980];
refline(1, 0)
title('Temperature Comparisons for 18\circ', 'FontSize', 15)
xlabel('Firewire (\circ C)', 'FontSize', 15)
ylabel('Temperature (\circ C)', 'FontSize', 15)
legend('Aspir', 'Rad', 'Location', 'southoutside', 'Orientation', 'horizontal', 'FontSize', 15)
legend('boxoff')
R2Str = num2str(stats4.Rsquared.ordinary);
R2Text = ['R^2 for Aspir = ', R2Str];
AvgStr = mean(Aspir_Data_Short_Min-FW_Data_Short);
AvgText = ['Mean Difference for Aspir = ', num2str(AvgStr)];
text(21.35,22.7,R2Text, 'FontSize', 13)
text(21.35,22.54, AvgText, 'FontSize', 13)
R2Str = num2str(stats5.Rsquared.ordinary);
R2Text = ['R^2 for Rad = ', R2Str];
AvgStr = mean(Rad_Data_Short_Min-FW_Data_Short);
AvgText = ['Mean Difference for Rad = ', num2str(AvgStr)];
text(21.35,23,R2Text, 'FontSize', 13)
text(21.35,22.85, AvgText, 'FontSize', 13)
grid on
hold off
end

