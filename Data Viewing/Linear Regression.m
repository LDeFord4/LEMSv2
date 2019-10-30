function [] = LinReg(SI111Time, SI111Data, LEMSTime1, LEMSData1, avgNum, avgUnit)
%LinReg performs linear regression on given data sets
%also computes fraction bias...
%avgNum = number of seconds over which it is averaged
%avgUnit for future development

% SI111Time = TimeDataArray(:, 1);
% SI111Data = TimeDataArray(:, 2);
% LEMSTime1 = TimeDataArray(:, 3);
% LEMSData1 = TimeDataArray(:, 4);
%%Notes:
    %help datetime is super helpful!!
    %between(LEMSTime1, LEMSTime2)
    %LEMSTime1.Day or .Minute or .Second, etc.
    %dateshift
    %diff function!  gives difference between datetimes
    %intersect function(A, B) returns (C,) IA, & IB, where the two intersect!

%%for 10.22.19 data:
    %LEMS is every ten seconds on the tens
    %CR3000 is every second

[~, ISI111Time, ILEMSTime1] = intersect(SI111Time, LEMSTime1);
m = avgNum; %seconds over which its averaged

SI111Time = SI111Time(ISI111Time(1):ISI111Time(end));
SI111Data = SI111Data(ISI111Time(1):ISI111Time(end));
LEMSTime1 = LEMSTime1(ILEMSTime1(1):ILEMSTime1(end));
LEMSData1 = LEMSData1(ILEMSTime1(1):ILEMSTime1(end));

SI111TimeAvg = linspace(SI111Time(1), SI111Time(end),(length(SI111Time)/m));
LEMSTime1Avg = linspace(LEMSTime1(1), LEMSTime1(end),(length(LEMSTime1)/(m/10)));
SI111DataAvg = zeros(1, length(SI111TimeAvg));
LEMSData1Avg = zeros(1, length(LEMSTime1Avg));

for i = 1:length(SI111TimeAvg)
    SI111DataAvg(i) = mean(SI111Data(((i-1)*m +1):(i*m)));
end

for i = 1:length(LEMSTime1Avg)
    LEMSData1Avg(i) = mean(LEMSData1(((i-1)*(m/10) +1):(i*(m/10))));
end

length(LEMSData1Avg)
LEMSTime1Avg(1)
LEMSTime1Avg(end)
length(SI111DataAvg)
SI111TimeAvg(1)
SI111TimeAvg(end)


%Regular plot, 
figure
plot(SI111TimeAvg, SI111DataAvg, 'kx', LEMSTime1Avg, LEMSData1Avg, 'bx')
legend("SI111", "MLX")
title("Averaged and linked Temperature vs. Time for SI111 and MLX")
ylabel("Temperature (\circ C)")
xlabel("Date (UTC)")


if SI111TimeAvg(1) ~= LEMSTime1Avg(1)
    error("not starting at the same time!")
end
if SI111TimeAvg(end) ~= LEMSTime1Avg(end)
    error("not ending at the same time")
end
if length(SI111TimeAvg) ~= length(LEMSTime1Avg)
    error("Time stamps not the same length")
end

%Linear Regression Plot
figure
plot(SI111DataAvg, LEMSData1Avg, 'kx')
refline(1, 0)
title("Linear Regression, MLX vs. SI111 10.22.19")
ylabel("MLX (\circ C)")
xlabel("SI111 (\circ C)")
%line of best fit,
%NB: SI111DataAvg is opp. LEMSData, 1 is column other is row vector
P = polyfit(SI111DataAvg, LEMSData1Avg, 1);
PText = ['The equation for the line of best fit is:',newline, 'y = ', num2str(P(1)), 'x + ', num2str(P(2))];
text(0, 25, PText);
%R^2
stats = fitlm(SI111DataAvg, LEMSData1Avg);
R2Str = num2str(stats.Rsquared.ordinary);
R2Text = ['R^2 value is ', R2Str];
text(0, 15, R2Text);
%fractional bias (?) right forumla?
FB = 1/length(SI111DataAvg) * sum(LEMSData1Avg - SI111DataAvg);
FBText = ['The fractional bias is: ', num2str(FB)];
text(0, 20, FBText);

%Lexi DeFord for LEMS project, 10/24/19-10/29/19
end
