%% MODULE 1: IoT Sensor Signal Modeling (Temperature + Humidity)
% Author: <Your Name>, NITK
% Course: Signals and Systems (EC Minor)
% Description:
%   Generate clean (noise-free) discrete-time signals for two IoT sensors:
%   1) Temperature (deg C)
%   2) Humidity (%)
%   These will act as the "true" sensor values before noise is added.

clear; close all; clc;

%% 1. Sampling parameters
Fs = 1;              % Sampling frequency (1 sample per second, for example)
T  = 1/Fs;           % Sampling period
N  = 500;            % Number of samples (e.g., 500 seconds of data)
n  = 0:N-1;          % Discrete-time index
t  = n * T;          % Time axis in seconds

%% 2. True Temperature signal (clean, noise-free)
% Idea:
%   Base level around 25 deg C
%   Slight upward trend with time
%   Small slow sinusoidal variation (like day-night fluctuation)

temp_base   = 25;           % base temperature in deg C
temp_trend  = 0.01 * n;     % slow linear increase (0.01 deg per sample)
temp_freq   = 0.01;         % normalized frequency for sinusoid
temp_amp    = 0.5;          % amplitude of temperature oscillation

temp_true = temp_base + temp_trend + ...
            temp_amp * sin(2*pi*temp_freq*n);

%% 3. True Humidity signal (clean, noise-free)
% Idea:
%   Base level around 60% RH
%   Slight downward trend with time
%   Sinusoidal variation with different frequency and phase

hum_base   = 60;            % base humidity in %
hum_trend  = -0.005 * n;    % slow decrease (e.g. drying environment)
hum_freq   = 0.008;         % different frequency for humidity
hum_amp    = 3;             % amplitude of humidity oscillation
hum_phase  = pi/4;          % phase shift

hum_true = hum_base + hum_trend + ...
           hum_amp * sin(2*pi*hum_freq*n + hum_phase);

%% 4. Plot the clean sensor signals
figure;
subplot(2,1,1);
plot(t, temp_true, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Temperature (^{\circ}C)');
title('Clean Temperature Sensor Signal (True)');
grid on;

subplot(2,1,2);
plot(t, hum_true, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Humidity (%)');
title('Clean Humidity Sensor Signal (True)');
grid on;

%% 5. (Optional) Show both on same figure with different y-axes (just for intuition)
figure;
yyaxis left;
plot(t, temp_true, 'LineWidth', 1.5);
ylabel('Temperature (^{\circ}C)');
yyaxis right;
plot(t, hum_true, '--', 'LineWidth', 1.5);
ylabel('Humidity (%)');
xlabel('Time (s)');
title('Clean IoT Sensor Signals: Temperature and Humidity');
grid on;

%% 6. Save variables for later modules
% We will use temp_true and hum_true in Module 2 for adding noise,
% and further filtering/prediction.
save('sensor_true_signals.mat', 't', 'n', 'temp_true', 'hum_true', 'Fs');
