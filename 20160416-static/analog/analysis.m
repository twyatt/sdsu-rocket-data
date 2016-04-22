% Perform analysis on accelerometer, gyroscope and barometer data.
% Uses the Curve Fit Toolbox
%
clc; clear;

smoothing = false;
n = 10; % number of values to use for the running average plot smoothing

trim = true;
start = 210;  % seconds
stop  = 425; % seconds

NANOSECONDS_PER_SECOND = 1000000000.0;

% http://www.mathworks.com/help/matlab/ref/textscan.html#inputarg_formatSpec

disp('Loading configuration...');
% Channel, Slope, Bias
Config = readtable('config.csv', 'Format', '%s%f%f');

disp('Loading A0: LOX (ADS1114) data...');
file = 'a0.csv';
% Timestamp (ns), Value (mV)
A0 = readtable(file, 'Format', '%u64%f');

disp('Loading A1: Kerosene (ADS1114) data...');
file = 'a1.csv';
% Timestamp (ns), Value (mV)
A1 = readtable(file, 'Format', '%u64%f');

disp('Loading A2: Helium (ADS1114) data...');
file = 'a2.csv';
% Timestamp (ns), Value (mV)
A2 = readtable(file, 'Format', '%u64%f');

disp('Loading A3: Motor (ADS1114) data...');
file = 'a3.csv';
% Timestamp (ns), Value (mV)
A3 = readtable(file, 'Format', '%u64%f');

disp('Generating analog graph...');
figure;
hold all;
grid on;
t0 = double(A0.Nanoseconds) / NANOSECONDS_PER_SECOND;
t1 = double(A1.Nanoseconds) / NANOSECONDS_PER_SECOND;
t2 = double(A2.Nanoseconds) / NANOSECONDS_PER_SECOND;
t3 = double(A3.Nanoseconds) / NANOSECONDS_PER_SECOND;
P0 = Config.Slope(1) .* A0.Millivolts + Config.Bias(1);
P1 = Config.Slope(2) .* A1.Millivolts + Config.Bias(2);
P2 = Config.Slope(3) .* A2.Millivolts + Config.Bias(3);
P3 = Config.Slope(4) .* A3.Millivolts + Config.Bias(4);
t0(isnan(P0)) = [];
t1(isnan(P1)) = [];
t2(isnan(P2)) = [];
t3(isnan(P3)) = [];
P0(isnan(P0)) = [];
P1(isnan(P1)) = [];
P2(isnan(P2)) = [];
P3(isnan(P3)) = [];
if (smoothing)
    P0 = smooth(P0, n, 'moving');
    P1 = smooth(P1, n, 'moving');
    P2 = smooth(P2, n, 'moving');
    P3 = smooth(P3, n, 'moving');
end
if (trim)
    P0(t0 < start | t0 > stop) = [];
    P1(t1 < start | t1 > stop) = [];
    P2(t2 < start | t2 > stop) = [];
    P3(t3 < start | t3 > stop) = [];
    t0(t0 < start | t0 > stop) = [];
    t1(t1 < start | t1 > stop) = [];
    t2(t2 < start | t2 > stop) = [];
    t3(t3 < start | t3 > stop) = [];
    t0 = t0 - start;
    t1 = t1 - start;
    t2 = t2 - start;
    t3 = t3 - start;
end
plot(t0, P0, 'LineSmoothing', 'on');
plot(t1, P1, 'LineSmoothing', 'on');
plot(t2, P2, 'LineSmoothing', 'on');
plot(t3, P3, 'LineSmoothing', 'on');

title('Analog');
xlabel('Time (s)');
ylabel('Pressure (PSI)');
legend('LOX', 'Kerosene', 'Helium', 'Motor');
