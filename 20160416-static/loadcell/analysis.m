% Perform analysis on accelerometer, gyroscope and barometer data.
% Uses the Curve Fit Toolbox
%
clc; clear;

smoothing = true;
n = 10; % number of values to use for the running average plot smoothing

trim = true;
start = 325;  % seconds
stop  = 380; % seconds

NANOSECONDS_PER_SECOND = 1000000000.0;

% http://www.mathworks.com/help/matlab/ref/textscan.html#inputarg_formatSpec

disp('Loading configuration...');
% Channel, Slope, Bias
Config = readtable('config.csv', 'Format', '%s%f%f');

disp('Loading Load Cell (Phidgets Bridge) data...');
file = 'loadcell.csv';
% Timestamp (ns), Value (mV/V)
loadcell = readtable(file, 'Format', '%u64%f');

disp('Generating Load Cell (Phidgets Bridge) graph...');
figure;
hold all;
grid on;
tloadcell = double(loadcell.Nanoseconds) / NANOSECONDS_PER_SECOND;
floadcell = Config.Slope(1) .* loadcell.mV_V + Config.Bias(1);
tloadcell(isnan(floadcell)) = [];
floadcell(isnan(floadcell)) = [];
if (smoothing)
    floadcell = smooth(floadcell, n, 'moving');
end
if (trim)
    floadcell(tloadcell < start | tloadcell > stop) = [];
    tloadcell(tloadcell < start | tloadcell > stop) = [];
    tloadcell = tloadcell - start;
end
plot(tloadcell, floadcell);
title('Load Cell');
xlabel('Time (s)');
ylabel('Force (lb)');
