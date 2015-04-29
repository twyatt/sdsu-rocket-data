% Perform analysis on accelerometer, gyroscope and barometer data.
% Uses the Curve Fit Toolbox
%
clc; clear;

% Data Acquisition 1 (top of rocket)
% Data Acquisition 2 (bottom of rocket)
% Data Acquisition 3 (2nd down from top of rocket)
system = 1;

smoothing = false;
n = 10; % number of values to use for the running average plot smoothing

trim = true;
if (system == 1)
    start = 600;  % seconds
    stop  = 1200; % seconds
elseif (system == 3)
    start = 5000;  % seconds
    stop  = 6000; % seconds
end

NANOSECONDS_PER_SECOND = 1000000000.0;


% http://www.mathworks.com/help/matlab/ref/textscan.html#inputarg_formatSpec

disp('Loading ADC (ADS1115) configuration...');
% Channel, Slope, Bias
ADS1115Config = readtable('ads1115-config.csv', 'Format', '%s%f%f');

disp('Loading ADC (ADS1115) data...');
file = ['data' num2str(system) '/ads1115.csv'];
% Timestamp (ns), A0 (mV), A1 (mV), A2 (mV), A3 (mV)
ADS1115 = readtable(file, 'Format', '%u64%f%f%f%f');

disp('Loading accelerometer (ADXL345) data...');
file = ['data' num2str(system) '/adxl345.csv'];
% Timestamp (ns), Multiplier, X*Multiplier (G), Y*Multiplier (G), Z*Multiplier (G)
ADXL345 = readtable(file, 'Format', '%u64%f%d%d%d');

disp('Loading gyroscope (ITG3205) data...');
file = ['data' num2str(system) '/itg3205.csv'];
% Timestamp (ns), Multiplier, X*Multiplier (deg/s), Y*Multiplier (deg/s), Z*Multiplier (deg/s)
ITG3205 = readtable(file, 'Format', '%u64%f%d%d%d');

disp('Loading magnetometer (HMC5883L) data...');
file = ['data' num2str(system) '/hmc5883l.csv'];
% Timestamp (ns), Multiplier, X*Multiplier (Gauss), Y*Multiplier (Gauss), Z*Multiplier (Gauss)
HMC5883L = readtable(file, 'Format', '%u64%f%d%d%d');

disp('Loading barometer (MS56111) data...');
file = ['data' num2str(system) '/ms5611.csv'];
% Timestamp (ns), Temperature/100 (C), Pressure/100 (mbar)
MS5611 = readtable(file, 'Format', '%u64%d%d');


disp('Generating pressures graph...');
figure;
hold all;
grid on;
t0 = double(ADS1115.Timestamp) / NANOSECONDS_PER_SECOND;
t1 = double(ADS1115.Timestamp) / NANOSECONDS_PER_SECOND;
t2 = double(ADS1115.Timestamp) / NANOSECONDS_PER_SECOND;
t3 = double(ADS1115.Timestamp) / NANOSECONDS_PER_SECOND;
P0 = ADS1115Config.Slope(1) .* ADS1115.A0 + ADS1115Config.Bias(1);
P1 = ADS1115Config.Slope(2) .* ADS1115.A1 + ADS1115Config.Bias(2);
P2 = ADS1115Config.Slope(3) .* ADS1115.A2 + ADS1115Config.Bias(3);
P3 = ADS1115Config.Slope(4) .* ADS1115.A3 + ADS1115Config.Bias(4);
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
title('Pressures');
xlabel('Time (s)');
ylabel('Pressure (PSI)');
legend('Motor', 'LOX', 'Kerosene', 'Helium');

disp('Generating accelerometer (ADXL345) graph...');
figure;
hold all;
grid on;
t = ADXL345.Timestamp / NANOSECONDS_PER_SECOND;
x = double(ADXL345.X) .* ADXL345.Multiplier;
y = double(ADXL345.Y) .* ADXL345.Multiplier;
z = double(ADXL345.Z) .* ADXL345.Multiplier;
if (smoothing)
    x = smooth(x, n, 'moving');
    y = smooth(y, n, 'moving');
    z = smooth(z, n, 'moving');
end
if (trim)
    mask = t < start | t > stop;
    t(mask) = [];
    x(mask) = [];
    y(mask) = [];
    z(mask) = [];
    t = t - start;
end
plot(t, x, 'LineSmoothing', 'on');
plot(t, y, 'LineSmoothing', 'on');
plot(t, z, 'LineSmoothing', 'on');
title('Accelerometer');
xlabel('Time (s)');
ylabel('Acceleration (G)');
legend('X', 'Y', 'Z');

disp('Generating gyroscope (ITG3205) graph...');
figure;
hold all;
grid on;
t = ITG3205.Timestamp / NANOSECONDS_PER_SECOND;
x = double(ITG3205.X) .* ITG3205.Multiplier;
y = double(ITG3205.Y) .* ITG3205.Multiplier;
z = double(ITG3205.Z) .* ITG3205.Multiplier;
if (smoothing)
    x = smooth(x, n, 'moving');
    y = smooth(y, n, 'moving');
    z = smooth(z, n, 'moving');
end
if (trim)
    mask = t < start | t > stop;
    t(mask) = [];
    x(mask) = [];
    y(mask) = [];
    z(mask) = [];
    t = t - start;
end
plot(t, x, 'LineSmoothing', 'on');
plot(t, y, 'LineSmoothing', 'on');
plot(t, z, 'LineSmoothing', 'on');
title('Gyroscope');
xlabel('Time (s)');
ylabel('Rotation Rate (^{\circ}/s)');
legend('X', 'Y', 'Z');

disp('Generating magnetometer (HMC5883L) graph...');
figure;
hold all;
grid on;
t = HMC5883L.Timestamp / NANOSECONDS_PER_SECOND;
x = double(HMC5883L.X) .* HMC5883L.Multiplier;
y = double(HMC5883L.Y) .* HMC5883L.Multiplier;
z = double(HMC5883L.Z) .* HMC5883L.Multiplier;
if (smoothing)
    x = smooth(x, n, 'moving');
    y = smooth(y, n, 'moving');
    z = smooth(z, n, 'moving');
end
if (trim)
    mask = t < start | t > stop;
    t(mask) = [];
    x(mask) = [];
    y(mask) = [];
    z(mask) = [];
    t = t - start;
end
plot(t, x, 'LineSmoothing', 'on');
plot(t, y, 'LineSmoothing', 'on');
plot(t, z, 'LineSmoothing', 'on');
title('Magnetometer');
xlabel('Time (s)');
ylabel('Magnetic Field (Gauss)');
legend('X', 'Y', 'Z');

disp('Generating barometer (MS5611) graph...');
figure;
hold all;
t = MS5611.Timestamp / NANOSECONDS_PER_SECOND;
temperature = double(MS5611.Temperature) / 100;
pressure    = double(MS5611.Pressure)    / 100;
if (trim)
    mask = t < start | t > stop;
    t(mask)           = [];
    temperature(mask) = [];
    pressure(mask)    = [];
    t = t - start;
end
[ax, p1, p2] = plotyy(t, temperature, t, pressure);
title('Barometer');
xlabel(ax(2), 'Time (s)');
ylabel(ax(1), 'Temperature (^{\circ}C)');
ylabel(ax(2), 'Pressure (mbar)');
