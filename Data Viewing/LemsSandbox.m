%LemsSandbox
%Lexi DeFord
%August 2020

% 
% if length(Rad_date_plot) >= length(Aspir_date_plot)
%     date_plotRadAspir = Rad_date_plot(1:length(Aspir_date_plot));
%     Rad_Data = Rad_Data(1:length(Aspir_Data));
%     fprintf("Using Rad_date_plot\n")
% else
%     date_plotRadAspir = Aspir_date_plot(1:length(Rad_date_plot));
%     Aspir_Data = Aspir_Data(1:length(Rad_Data));
%     fprintf("Using Aspir_date_plot\n")
% end


dateStr = '9.16.20';
Rad_Data = SHT_Amb_C;
Rad_Time = date_plot2;
Aspir_Data = SHT_Amb_C2;
Aspir_Time = date_plot2;

% making night and day vectors

day_start = 13;
night_start = 1;
nidx = 1;
didx = 1;

half_time = round(length(Rad_Data)/2);
half_date_time = Rad_Time(1:half_time);

g = 1;
j = 1;
p = 1;

Rad_Data_Night = [];
Aspir_Data_Night = [];

if (Rad_Time.Hour(1) < day_start) & (Rad_Time.Hour(1) > night_start)
    %then the data starts at night
    fprintf('Data starts at night\n')
    defNight = (day_start - Rad_Time.Hour(1)-1) * 60 * 6;
    Rad_Data_Night = Rad_Data(1:defNight);
    Rad_Time_Night = Rad_Time(1:defNight);
    Aspir_Data_Night = Aspir_Data(1:defNight);
    j = defNight+1;
    while Rad_Time.Hour(j) < day_start
        Rad_Data_Night(j) = Rad_Data(j);
        Rad_Time_Night(j) = Rad_Time(j);
        Aspir_Data_Night(j) = Aspir_Data(j);
        j = j + 1;
    end
    p = j+1;
else
    %data starts during the day
    fprintf('Data starts during the day\n')
    defDay = (25 - Rad_Time.Hour(1)-1) * 60 * 6;
    Rad_Data_Day = Rad_Data(1:defDay);
    Rad_Time_Day = Rad_Time(1:defDay);
    Aspir_Data_Day = Aspir_Data(1:defDay);
    g = defDay+1;
    while Rad_Time.Hour(g) < night_start
        Rad_Data_Day(g) = Rad_Data(g);
        Rad_Time_Day(g) = Rad_Time(g);
        Aspir_Data_Day(g) = Aspir_Data(g);
        g = g + 1;
    end
    p = g+1;
    Rad_Data_Night = [Rad_Data_Night;Rad_Data(p:(p+12*60*6))];
    %Rad_Time_Night = [Rad_Time_Night;Rad_Time(p:(p+12*60*6))];
    Aspir_Data_Night = [Aspir_Data_Night,Aspir_Data(p:(p+12*60*6))];
    p = p+12*60*6;
    while p < (length(Rad_Data)-(24*60*6))
        Rad_Data_Day = [Rad_Data_Day;Rad_Data(p:(p+12*60*6))];
        %Rad_Time_Day = [Rad_Time_Day;Rad_Time(p:(p+12*60*6))];
        Aspir_Data_Day = [Aspir_Data_Day;Aspir_Data(p:(p+12*60*6))];
        p = p + (12*60*6);
        Rad_Data_Night = [Rad_Data_Night;Rad_Data(p:(p+12*60*6))];
        %Rad_Time_Night = [Rad_Time_Night,Rad_Time(p:(p+12*60*6))];
        Aspir_Data_Night = [Aspir_Data_Night;Aspir_Data(p:(p+12*60*6))];
        p = p + (12*60*6);
    end
end
if (Rad_Time.Hour(end) < day_start) & (Rad_Time.Hour(end) > night_start)
    %then the data ends at night
    fprintf('Data ends at night\n')
    Rad_Data_Day = [Rad_Data_Day,Rad_Data(p:(p+12*60*6))];
    %Rad_Time_Day = [Rad_Time_Day,Rad_Time(p:(p+12*60*6))];
    Aspir_Data_Day = [Aspir_Data_Day,Aspir_Data(p:(p+12*60*6))];
    p = p + (12*60*6);
    Rad_Data_Night = [Rad_Data_Night,Rad_Data(p:end)];
    %Rad_Time_Night = [Rad_Time_Night,Rad_Time(p:end)];
    Aspir_Data_Night = [Aspir_Data_Night,Aspir_Data(p:end)];
else
    %data ends during the day
    fprintf('Data ends during the day\n')
    Rad_Data_Day = [Rad_Data_Day;Rad_Data(p:end)];
    %Rad_Time_Day = [Rad_Time_Day,Rad_Time(p:end)];
    Aspir_Data_Day = [Aspir_Data_Day;Aspir_Data(p:end)];
end

% taking one minute averages

Rad_Data_Avg = zeros(round(length(Rad_Data)/6),1);
Rad_Time_Avg = Rad_Time(1:6:end-1);
for k = 1:(length(Rad_Data)/6 - 1)
    Rad_Data_Avg(k) = mean(Rad_Data((6*k):(6*k+6)));
end
Aspir_Data_Avg = zeros(round(length(Aspir_Data)/6),1);
Aspir_Time_Avg = Aspir_Time(1:6:end-1);
for k = 1:(length(Aspir_Data)/6 - 1)
    Aspir_Data_Avg(k) = mean(Aspir_Data((6*k):(6*k+6)));
end

%calculating stats
statsTotal = fitlm(Rad_Data, Aspir_Data);
statsAvg = fitlm(Rad_Data_Avg, Aspir_Data_Avg);
statsDay = fitlm(Rad_Data_Day, Aspir_Data_Day);
statsNight = fitlm(Rad_Data_Night, Aspir_Data_Night);


%% Statistics of Rad and Aspir (two SHTs) (in total)

figure
hold on
plot(Rad_Data, Aspir_Data, 'b*')
refline(1, 0)
% title({dateStr; 'Aspirated Sensor vs. Radiation Shield (in total)'})
title({dateStr; 'Mary vs. Pippin Aspir (in total)'})
% xlabel('Rad (\circ C)')
% ylabel('Aspir (\circ C)')
xlabel('Pippin (\circ C)')
ylabel('Mary (\circ C)')
R2Str = num2str(statsTotal.Rsquared.ordinary);
R2Text = ['R^2 value is ', R2Str];
AvgStr = mean(Aspir_Data-Rad_Data);
AvgText = ['Mean Difference is ', num2str(AvgStr)];
annotation('textbox',[.15 .55 .35 .35], 'String', {R2Text;AvgText});
hold off

%% Statistics of Rad and Aspir (two SHTs) (one minute averages)

figure
hold on
plot(Rad_Data_Avg, Aspir_Data_Avg, 'b*')
refline(1, 0)
% title({dateStr;'Aspirated Sensor vs. Radiation Shield, 1 Minute Averages'})
% xlabel('Rad (\circ C)')
% ylabel('Aspir (\circ C)')
title({dateStr;'Mary vs. Pippin Aspir 1 Minute Averages'})
xlabel('Pippin (\circ C)')
ylabel('Mary (\circ C)')
R2Str = num2str(statsAvg.Rsquared.ordinary);
R2Text = ['R^2 value is ', R2Str];
AvgStr = mean(Aspir_Data_Avg-Rad_Data_Avg);
AvgText = ['Mean Difference is ', num2str(AvgStr)];
annotation('textbox',[.15 .55 .35 .35], 'String', {R2Text;AvgText});
hold off
%% Statistics of Rad and Aspir (two SHTs) (day)

figure
hold on
plot(Rad_Data_Day, Aspir_Data_Day, 'y*')
refline(1, 0)
% title({dateStr;'Aspirated Sensor vs. Radiation Shield Day'})
% xlabel('Rad (\circ C)')
% ylabel('Aspir (\circ C)')
title({dateStr;'Mary vs. Pippin Aspir Day'})
xlabel('Pippin (\circ C)')
ylabel('Mary (\circ C)')
R2StrDay = num2str(statsDay.Rsquared.ordinary);
R2TextDay = ['R^2 value for Day is ', R2StrDay];
AvgStrDay = mean(Aspir_Data_Day-Rad_Data_Day);
AvgTextDay = ['Mean Difference for Day is ', num2str(AvgStrDay)];
NValueDay = ['Number of Day Data Points is ', num2str(length(Rad_Data_Day))];
annotation('textbox',[.15 .55 .35 .35], 'String', {R2TextDay;AvgTextDay;NValueDay});
hold off
%% Statistics of Rad and Aspir (two SHTs) (night)

figure
hold on
plot(Rad_Data_Night, Aspir_Data_Night, 'k*')
refline(1, 0)
% title({dateStr;'Aspirated Sensor vs. Radiation Shield Night'})
% xlabel('Rad (\circ C)')
% ylabel('Aspir (\circ C)')
title({dateStr;'Mary vs. Pippin Aspir Night'})
xlabel('Pippin (\circ C)')
ylabel('Mary (\circ C)')
R2StrNight = num2str(statsNight.Rsquared.ordinary);
R2TextNight = ['R^2 value for Night is ', R2StrNight];
AvgStrNight = mean(Aspir_Data_Night-Rad_Data_Night);
AvgTextNight = ['Mean Difference for Night is ', num2str(AvgStrNight)];
NValueNight = ['Number of Night Data Points is ', num2str(length(Rad_Data_Night))];
annotation('textbox',[.15 .55 .35 .35], 'String', {R2TextNight;AvgTextNight;NValueNight});
hold off
%% Statistics of Rad and Aspir (two SHTs) (day vs. night)

figure
hold on
plot(Rad_Data_Day, Aspir_Data_Day, 'y*', Rad_Data_Night, Aspir_Data_Night, 'k*')
refline(1, 0)
% title({dateStr;'Aspirated Sensor vs. Radiation Shield Day vs. Night'})
% xlabel('Rad (\circ C)')
% ylabel('Aspir (\circ C)')
title({dateStr;'Mary vs. Pippin Aspir Day vs. Night'})
xlabel('Pippin (\circ C)')
ylabel('Mary (\circ C)')
annotation('textbox',[.15 .55 .35 .35], 'String', {R2TextDay;AvgTextDay;NValueDay;R2TextNight;AvgTextNight;NValueNight});
hold off
