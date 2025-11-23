%% MODULE 4: Prediction using AR(1) Model
% We use the best filtered signals (temp_filt, hum_filt) from Module 3
% and build an AR(1) model for each sensor.
% Then we perform one-step-ahead prediction and evaluate the prediction error.

clc;  % if separate file
load('sensor_filtered_signals.mat');  % contains temp_filt, hum_filt, t, n, Fs, etc.

%% 1. Train-test split
train_ratio = 0.8;
N           = length(n);
N_train     = floor(train_ratio * N);

% Temperature
temp_train = temp_filt(1:N_train);
temp_test  = temp_filt(N_train+1:end);
t_test     = t(N_train+1:end);
N_test     = length(temp_test);

% Humidity
hum_train = hum_filt(1:N_train);
hum_test  = hum_filt(N_train+1:end);

%% 2. Estimate AR(1) parameter 'a' for Temperature
% a_temp = sum(x[n]*x[n-1]) / sum(x[n-1]^2) over training region

num_temp = sum(temp_train(2:end) .* temp_train(1:end-1));
den_temp = sum(temp_train(1:end-1).^2);
a_temp   = num_temp / den_temp;

fprintf('\nEstimated AR(1) coefficient for Temperature: a_temp = %.4f\n', a_temp);

%% 3. One-step-ahead prediction for Temperature (on test region)
temp_pred = zeros(1, N_test);

% One-step-ahead prediction:
%   \hat{x}[k] = a * x[k-1]
% For the first test sample, use last training sample as x[k-1]
prev_val = temp_train(end);

for k = 1:N_test
    temp_pred(k) = a_temp * prev_val;
    % For one-step-ahead real prediction, we then update prev_val with the actual test value
    prev_val = temp_test(k);
end

% Prediction error and MSE
temp_pred_error = temp_test - temp_pred;
mse_temp_pred   = mean(temp_pred_error.^2);
fprintf('Temperature AR(1) prediction MSE = %.4f\n', mse_temp_pred);

%% 4. Estimate AR(1) parameter 'a' for Humidity
num_hum = sum(hum_train(2:end) .* hum_train(1:end-1));
den_hum = sum(hum_train(1:end-1).^2);
a_hum   = num_hum / den_hum;

fprintf('Estimated AR(1) coefficient for Humidity   : a_hum  = %.4f\n', a_hum);

%% 5. One-step-ahead prediction for Humidity
N_test_hum = length(hum_test);
hum_pred   = zeros(1, N_test_hum);

prev_val = hum_train(end);
for k = 1:N_test_hum
    hum_pred(k) = a_hum * prev_val;
    prev_val = hum_test(k);
end

hum_pred_error = hum_test - hum_pred;
mse_hum_pred   = mean(hum_pred_error.^2);
fprintf('Humidity AR(1) prediction MSE   = %.4f\n', mse_hum_pred);

%% 6. Plot Temperature: Actual vs Predicted (Test Region)
figure;
plot(t_test, temp_test, 'LineWidth', 1.5); hold on;
plot(t_test, temp_pred, '--', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Temperature (^{\circ}C)');
title('Temperature: AR(1) One-Step-Ahead Prediction (Test Region)');
legend('Actual Filtered', 'Predicted');
grid on;

%% 7. Plot Humidity: Actual vs Predicted (Test Region)
figure;
plot(t_test, hum_test, 'LineWidth', 1.5); hold on;
plot(t_test, hum_pred, '--', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Humidity (%)');
title('Humidity: AR(1) One-Step-Ahead Prediction (Test Region)');
legend('Actual Filtered', 'Predicted');
grid on;

%% 8. Save prediction results for later modules (anomaly detection, etc.)
save('sensor_prediction_results.mat', ...
     't', 'n', ...
     'temp_filt', 'hum_filt', ...
     'temp_test', 'hum_test', ...
     'temp_pred', 'hum_pred', ...
     'mse_temp_pred', 'mse_hum_pred', ...
     'a_temp', 'a_hum', 'Fs');
