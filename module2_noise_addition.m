%% MODULE 2: Noise Injection & Basic Analysis
% We add realistic noise to the clean temperature and humidity signals:
%   - Gaussian noise (measurement noise)
%   - Random spikes (sensor glitches)
%   - Optional slow drift
% Then we compare true vs noisy signals.

%% 1. Gaussian noise parameters
temp_noise_std = 0.8;   % standard deviation for temperature noise (deg C)
hum_noise_std  = 2.0;   % standard deviation for humidity noise (%)

% Generate Gaussian noise
temp_gauss_noise = temp_noise_std * randn(size(temp_true));
hum_gauss_noise  = hum_noise_std  * randn(size(hum_true));

% Add Gaussian noise to true signals
temp_noisy = temp_true + temp_gauss_noise;
hum_noisy  = hum_true  + hum_gauss_noise;

%% 2. Add random spike noise (sensor glitches)
num_spikes_temp = 8;    % number of spikes in entire signal
num_spikes_hum  = 8;

% Random spike positions
spike_pos_temp = randi([1 N], 1, num_spikes_temp);
spike_pos_hum  = randi([1 N], 1, num_spikes_hum);

% Spike amplitudes (positive or negative)
temp_spike_amp = 5 * (2*rand(1, num_spikes_temp) - 1);  % between -5 and +5 deg C
hum_spike_amp  = 10 * (2*rand(1, num_spikes_hum)  - 1); % between -10 and +10 %

% Add spikes
for k = 1:num_spikes_temp
    temp_noisy(spike_pos_temp(k)) = temp_noisy(spike_pos_temp(k)) + temp_spike_amp(k);
end
for k = 1:num_spikes_hum
    hum_noisy(spike_pos_hum(k)) = hum_noisy(spike_pos_hum(k)) + hum_spike_amp(k);
end

%% 3. Optional: Add slow drift to temperature sensor
add_drift = true;
if add_drift
    drift_temp = 0.002 * n;          % very slow drift upwards
    temp_noisy = temp_noisy + drift_temp;
end

%% 4. Basic error measurement (MSE and approximate SNR)
% Mean Squared Error
mse_temp = mean((temp_noisy - temp_true).^2);
mse_hum  = mean((hum_noisy  - hum_true ).^2);

% Approximate signal power and noise power
sig_power_temp = mean(temp_true.^2);
noise_power_temp = mean((temp_noisy - temp_true).^2);
snr_temp_db = 10*log10(sig_power_temp / noise_power_temp);

sig_power_hum = mean(hum_true.^2);
noise_power_hum = mean((hum_noisy - hum_true).^2);
snr_hum_db = 10*log10(sig_power_hum / noise_power_hum);

fprintf('Temperature: MSE = %.4f, SNR ≈ %.2f dB\n', mse_temp, snr_temp_db);
fprintf('Humidity   : MSE = %.4f, SNR ≈ %.2f dB\n', mse_hum,  snr_hum_db);

%% 5. Plot true vs noisy signals for temperature
figure;
subplot(2,1,1);
plot(t, temp_true, 'LineWidth', 1.5); hold on;
plot(t, temp_noisy, ':', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Temperature (^{\circ}C)');
title('Temperature: True vs Noisy (Gaussian + Spikes + Drift)');
legend('True Temperature', 'Noisy Temperature');
grid on;

% Zoomed-in view to clearly see noise and spikes
subplot(2,1,2);
zoom_range = 1:100; % first 100 samples
plot(t(zoom_range), temp_true(zoom_range), 'LineWidth', 1.5); hold on;
plot(t(zoom_range), temp_noisy(zoom_range), ':', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Temperature (^{\circ}C)');
title('Zoomed View (First 100 Samples)');
legend('True Temperature', 'Noisy Temperature');
grid on;

%% 6. Plot true vs noisy signals for humidity
figure;
subplot(2,1,1);
plot(t, hum_true, 'LineWidth', 1.5); hold on;
plot(t, hum_noisy, ':', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Humidity (%)');
title('Humidity: True vs Noisy (Gaussian + Spikes)');
legend('True Humidity', 'Noisy Humidity');
grid on;

subplot(2,1,2);
plot(t(zoom_range), hum_true(zoom_range), 'LineWidth', 1.5); hold on;
plot(t(zoom_range), hum_noisy(zoom_range), ':', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Humidity (%)');
title('Zoomed View (First 100 Samples)');
legend('True Humidity', 'Noisy Humidity');
grid on;

%% 7. Save noisy signals for later modules
save('sensor_noisy_signals.mat', ...
     't', 'n', 'temp_true', 'hum_true', ...
     'temp_noisy', 'hum_noisy', ...
     'Fs');
