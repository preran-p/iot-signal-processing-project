%% MODULE 3: Digital Filtering - FIR, IIR, and Kalman
% We apply three filtering techniques to the noisy temperature and humidity
% signals:
%   1) Moving Average FIR filter
%   2) IIR Exponential Smoothing filter
%   3) 1-D Kalman filter
% Then we compare their performance using MSE and plots.

%% 1. Moving Average FIR Filter (same window for both sensors)
M = 5;                        % window length
h_ma = ones(1, M)/M;          % FIR impulse response for moving average

% Convolution with 'same' to keep original length
temp_fir = conv(temp_noisy, h_ma, 'same');
hum_fir  = conv(hum_noisy,  h_ma, 'same');

%% 2. IIR Exponential Smoothing Filter
alpha_temp = 0.2;             % smoothing factor for temperature
alpha_hum  = 0.2;             % smoothing factor for humidity

temp_iir = zeros(size(temp_noisy));
hum_iir  = zeros(size(hum_noisy));

% Initialize with first noisy value
temp_iir(1) = temp_noisy(1);
hum_iir(1)  = hum_noisy(1);

% Apply the recursive formula:
% y[n] = alpha * x[n] + (1 - alpha) * y[n-1]
for k = 2:N
    temp_iir(k) = alpha_temp * temp_noisy(k) + (1 - alpha_temp) * temp_iir(k-1);
    hum_iir(k)  = alpha_hum  * hum_noisy(k)  + (1 - alpha_hum)  * hum_iir(k-1);
end

%% 3. 1-D Kalman Filter for Temperature
% State model:
%   x_k = x_{k-1} + w_k
%   z_k = x_k + v_k
% where w_k ~ N(0, Q), v_k ~ N(0, R)

Q_temp = 0.001;               % process noise covariance (small)
R_temp = temp_noise_std^2;    % measurement noise covariance (from Module 2)

temp_kal = zeros(1, N);       % estimated temperature
P_temp   = zeros(1, N);       % error covariance

% Initial estimate and covariance
temp_kal(1) = temp_noisy(1);
P_temp(1)   = 1;

for k = 2:N
    % Prediction step
    x_pred = temp_kal(k-1);         % predicted state
    P_pred = P_temp(k-1) + Q_temp;  % predicted covariance

    % Kalman gain
    K = P_pred / (P_pred + R_temp);

    % Correction step
    temp_kal(k) = x_pred + K * (temp_noisy(k) - x_pred);
    P_temp(k)   = (1 - K) * P_pred;
end

%% 4. 1-D Kalman Filter for Humidity
Q_hum = 0.005;                % process noise covariance for humidity
R_hum = hum_noise_std^2;      % measurement noise covariance

hum_kal = zeros(1, N);
P_hum   = zeros(1, N);

hum_kal(1) = hum_noisy(1);
P_hum(1)   = 1;

for k = 2:N
    % Prediction
    x_pred = hum_kal(k-1);
    P_pred = P_hum(k-1) + Q_hum;

    % Kalman gain
    K = P_pred / (P_pred + R_hum);

    % Correction
    hum_kal(k) = x_pred + K * (hum_noisy(k) - x_pred);
    P_hum(k)   = (1 - K) * P_pred;
end

%% 5. Compute MSE for each filter (Temperature)
mse_temp_fir = mean((temp_fir - temp_true).^2);
mse_temp_iir = mean((temp_iir - temp_true).^2);
mse_temp_kal = mean((temp_kal - temp_true).^2);

%% 6. Compute MSE for each filter (Humidity)
mse_hum_fir = mean((hum_fir - hum_true).^2);
mse_hum_iir = mean((hum_iir - hum_true).^2);
mse_hum_kal = mean((hum_kal - hum_true).^2);

%% 7. Print MSE values
fprintf('\n=== FILTER PERFORMANCE (Temperature) ===\n');
fprintf('FIR Moving Average MSE   = %.4f\n', mse_temp_fir);
fprintf('IIR Exponential MSE      = %.4f\n', mse_temp_iir);
fprintf('Kalman Filter MSE        = %.4f\n', mse_temp_kal);

fprintf('\n=== FILTER PERFORMANCE (Humidity) ===\n');
fprintf('FIR Moving Average MSE   = %.4f\n', mse_hum_fir);
fprintf('IIR Exponential MSE      = %.4f\n', mse_hum_iir);
fprintf('Kalman Filter MSE        = %.4f\n', mse_hum_kal);

%% 8. Plot results for Temperature (True vs Noisy vs Filtered)
figure;
subplot(3,1,1);
plot(t, temp_true, 'LineWidth', 1.5); hold on;
plot(t, temp_noisy, ':', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Temp (^{\circ}C)');
title('Temperature: True vs Noisy');
legend('True', 'Noisy');
grid on;

subplot(3,1,2);
plot(t, temp_true, 'LineWidth', 1.5); hold on;
plot(t, temp_fir, 'LineWidth', 1);
plot(t, temp_iir, 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Temp (^{\circ}C)');
title('Temperature: FIR vs IIR vs True');
legend('True', 'FIR (MA)', 'IIR');
grid on;

subplot(3,1,3);
plot(t, temp_true, 'LineWidth', 1.5); hold on;
plot(t, temp_kal, 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Temp (^{\circ}C)');
title('Temperature: Kalman Filter vs True');
legend('True', 'Kalman');
grid on;

%% 9. Plot results for Humidity (True vs Noisy vs Filtered)
figure;
subplot(3,1,1);
plot(t, hum_true, 'LineWidth', 1.5); hold on;
plot(t, hum_noisy, ':', 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Humidity (%)');
title('Humidity: True vs Noisy');
legend('True', 'Noisy');
grid on;

subplot(3,1,2);
plot(t, hum_true, 'LineWidth', 1.5); hold on;
plot(t, hum_fir, 'LineWidth', 1);
plot(t, hum_iir, 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Humidity (%)');
title('Humidity: FIR vs IIR vs True');
legend('True', 'FIR (MA)', 'IIR');
grid on;

subplot(3,1,3);
plot(t, hum_true, 'LineWidth', 1.5); hold on;
plot(t, hum_kal, 'LineWidth', 1);
xlabel('Time (s)');
ylabel('Humidity (%)');
title('Humidity: Kalman Filter vs True');
legend('True', 'Kalman');
grid on;

%% 10. Choose a "best" filtered signal for further modules
% For simplicity, we can pick the filter with the lowest MSE.

[~, best_temp_idx] = min([mse_temp_fir, mse_temp_iir, mse_temp_kal]);
[~, best_hum_idx]  = min([mse_hum_fir,  mse_hum_iir,  mse_hum_kal]);

if best_temp_idx == 1
    temp_filt = temp_fir;
    best_temp_name = 'FIR Moving Average';
elseif best_temp_idx == 2
    temp_filt = temp_iir;
    best_temp_name = 'IIR Exponential';
else
    temp_filt = temp_kal;
    best_temp_name = 'Kalman Filter';
end

if best_hum_idx == 1
    hum_filt = hum_fir;
    best_hum_name = 'FIR Moving Average';
elseif best_hum_idx == 2
    hum_filt = hum_iir;
    best_hum_name = 'IIR Exponential';
else
    hum_filt = hum_kal;
    best_hum_name = 'Kalman Filter';
end

fprintf('\nBest Temperature Filter (by MSE): %s\n', best_temp_name);
fprintf('Best Humidity Filter   (by MSE): %s\n', best_hum_name);

%% 11. Save filtered outputs for later modules (prediction, FFT, anomaly)
save(fullfile('data', 'sensor_filtered_signals.mat'), ...
     't','n', ...
     'temp_true','hum_true', ...
     'temp_noisy','hum_noisy', ...
     'temp_fir','hum_fir', ...
     'temp_iir','hum_iir', ...
     'temp_kal','hum_kal', ...
     'temp_filt','hum_filt', ...
     'best_temp_name','best_hum_name', ...
     'Fs');

