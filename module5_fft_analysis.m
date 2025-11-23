%% MODULE 5: Frequency Domain Analysis using FFT (Improved Version)
% Shows clear spectra by:
%   - removing DC (subtract mean)
%   - using only 0..Fs/2
%   - normalising magnitude to [0,1]

clc;
load('sensor_filtered_signals.mat');   % loads temp_true, temp_noisy, temp_filt, etc.

%% 1. Basic parameters
N  = length(n);
Fs = Fs;               % sampling frequency (already stored)
N2 = floor(N/2);       % half spectrum
f  = (0:N2-1) * (Fs/N);

%% 2. Detrend (remove mean) for all signals

% Temperature
temp_true_zm   = temp_true   - mean(temp_true);
temp_noisy_zm  = temp_noisy  - mean(temp_noisy);
temp_filt_zm   = temp_filt   - mean(temp_filt);

% Humidity
hum_true_zm    = hum_true    - mean(hum_true);
hum_noisy_zm   = hum_noisy   - mean(hum_noisy);
hum_filt_zm    = hum_filt    - mean(hum_filt);

%% 3. Compute FFT magnitudes and normalise to [0,1]

% Temperature
FFT_temp_true  = abs(fft(temp_true_zm));
FFT_temp_noisy = abs(fft(temp_noisy_zm));
FFT_temp_filt  = abs(fft(temp_filt_zm));

FFT_temp_true  = FFT_temp_true(1:N2)  / max(FFT_temp_true(1:N2));
FFT_temp_noisy = FFT_temp_noisy(1:N2) / max(FFT_temp_noisy(1:N2));
FFT_temp_filt  = FFT_temp_filt(1:N2)  / max(FFT_temp_filt(1:N2));

% Humidity
FFT_hum_true   = abs(fft(hum_true_zm));
FFT_hum_noisy  = abs(fft(hum_noisy_zm));
FFT_hum_filt   = abs(fft(hum_filt_zm));

FFT_hum_true   = FFT_hum_true(1:N2)   / max(FFT_hum_true(1:N2));
FFT_hum_noisy  = FFT_hum_noisy(1:N2)  / max(FFT_hum_noisy(1:N2));
FFT_hum_filt   = FFT_hum_filt(1:N2)   / max(FFT_hum_filt(1:N2));

%% 4. Plot Temperature Spectra (0 .. Fs/2)

figure;
subplot(3,1,1);
plot(f, FFT_temp_true, 'LineWidth', 1.5);
title('Temperature - Normalised FFT of True Signal');
xlabel('Frequency (Hz)');
ylabel('Normalised |X(f)|');
grid on;

subplot(3,1,2);
plot(f, FFT_temp_noisy, 'LineWidth', 1.5);
title('Temperature - Normalised FFT of Noisy Signal');
xlabel('Frequency (Hz)');
ylabel('Normalised |X(f)|');
grid on;

subplot(3,1,3);
plot(f, FFT_temp_filt, 'LineWidth', 1.5);
title(['Temperature - Normalised FFT of Filtered Signal (' best_temp_name ')']);
xlabel('Frequency (Hz)');
ylabel('Normalised |X(f)|');
grid on;

%% 5. Plot Humidity Spectra (0 .. Fs/2)

figure;
subplot(3,1,1);
plot(f, FFT_hum_true, 'LineWidth', 1.5);
title('Humidity - Normalised FFT of True Signal');
xlabel('Frequency (Hz)');
ylabel('Normalised |X(f)|');
grid on;

subplot(3,1,2);
plot(f, FFT_hum_noisy, 'LineWidth', 1.5);
title('Humidity - Normalised FFT of Noisy Signal');
xlabel('Frequency (Hz)');
ylabel('Normalised |X(f)|');
grid on;

subplot(3,1,3);
plot(f, FFT_hum_filt, 'LineWidth', 1.5);
title(['Humidity - Normalised FFT of Filtered Signal (' best_hum_name ')']);
xlabel('Frequency (Hz)');
ylabel('Normalised |X(f)|');
grid on;

%% 6. Save FFT results for the report or later modules (optional)
save('sensor_fft_results.mat', ...
    'f', ...
    'FFT_temp_true', 'FFT_temp_noisy', 'FFT_temp_filt', ...
    'FFT_hum_true', 'FFT_hum_noisy', 'FFT_hum_filt');
