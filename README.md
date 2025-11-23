📘 IoT Sensor Signal Processing – Noise Reduction, Prediction & FFT Analysis (MATLAB Project)
Signals and Systems (EC Minor Project)

Author: Your Name (NITK Surathkal)
Course: Signals & Systems (EC Minor)

📌 Project Summary

This MATLAB project simulates IoT environmental sensor data (Temperature & Humidity), adds realistic noise, and then applies digital signal processing techniques to clean, analyze, and predict the sensor readings.

The project demonstrates core Signals & Systems concepts using a Computer Science + IoT application.

🧠 What This Project Does

This project performs the following:

✔ 1. Sensor Signal Modeling (Temperature + Humidity)

Creates clean, noise-free IoT sensor signals with trends + sinusoidal variations.

✔ 2. Noise Addition

Adds realistic noise:

Gaussian measurement noise

Random spikes

Drift (only for temperature)

✔ 3. Filtering and Smoothing

Applies:

FIR Moving Average

IIR Exponential Smoothing

Kalman Filter (1-D)

Compares them using MSE and selects the best filter.

✔ 4. Prediction (AR(1) Model)

Short-term prediction using autoregressive modeling.

✔ 5. Frequency Domain Analysis (FFT)

Plots:

True signal spectrum

Noisy spectrum

Filtered spectrum

With DC removal + normalisation so the plots are clearly visible.

✔ 6. Results Export

All figures saved automatically to the results/ folder.

📁 Repository Structure
.
├── module1_signal_modeling.m
├── module2_noise_addition.m
├── module3_filtering.m
├── module4_prediction.m
├── module5_fft_analysis.m
├── run_all_modules.m
├── save_all_figures.m
│
├── data/     
│   ├── sensor_true_signals.mat
│   ├── sensor_noisy_signals.mat
│   ├── sensor_filtered_signals.mat
│   ├── sensor_prediction_results.mat
│   └── sensor_fft_results.mat
│
└── results/
    ├── figure_1.png
    ├── figure_2.png
    ├── ...
    └── figure_10.png

✔ data/ contains intermediate .mat files
✔ results/ contains all plots generated automatically
✔ MATLAB scripts remain in the main folder for easy running
⚙️ How to Run This Project
1. Clone the Repository
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>

2. Open MATLAB

Set MATLAB Current Folder to the repository folder.

3. Run the main controller script

In MATLAB:

run_all_modules


This will:

Run all five modules

Generate all figures

Save .mat files into data/

Save .png figures into results/ (through save_all_figures.m)

All 10 figures will be automatically generated.

🧩 Module Explanations

This is what each script in your repo does.

🔹 Module 1 — Sensor Signal Modeling

File: module1_signal_modeling.m

Generates clean, noise-free sensor signals:

Temperature model

Base value: 25°C

Linear upward trend

Low-frequency sinusoidal fluctuation

Humidity model

Base: 60%

Slight downward trend

Sinusoidal variation with phase shift

Outputs:

Two time-domain clean signals

sensor_true_signals.mat

🔹 Module 2 — Noise Addition

File: module2_noise_addition.m

Adds realistic noise:

Types of noise added:

Gaussian noise

Random spikes

Slow drift (only for temperature)

Outputs:

Noisy temperature

Noisy humidity

SNR estimation

Comparison plots

sensor_noisy_signals.mat

🔹 Module 3 — Filtering (FIR, IIR, Kalman)

File: module3_filtering.m

Applies three filters:

1. FIR Moving Average

Simple linear smoother

Uses convolution

2. IIR Exponential Filter

First-order smoothing

Uses recursive filtering

3. Kalman Filter

Performs prediction + correction

Gives the smoothest output

The script calculates MSE for each filter, then automatically selects:

Best filter for temperature

Best filter for humidity

Outputs:

Filtered signals

Filter performance plots

sensor_filtered_signals.mat

🔹 Module 4 — AR(1) Prediction

File: module4_prediction.m

Steps:

Split data (80% training, 20% test)

Compute AR(1) coefficient

Predict next sample using:

𝑥
[
𝑛
]
=
𝑎
⋅
𝑥
[
𝑛
−
1
]
x[n]=a⋅x[n−1]

Measure prediction error

Plot actual vs predicted signal

Outputs:

Temperature predictions

Humidity predictions

Prediction error

sensor_prediction_results.mat

🔹 Module 5 — FFT Analysis

File: module5_fft_analysis.m

Computes FFTs for:

True signals

Noisy signals

Filtered signals

Improvements implemented:

Mean removal (to remove DC spike)

Normalised magnitude spectrum

Half-spectrum plotting (0 to Fs/2)

This makes spectral differences clearly visible.

Outputs:

6 FFT plots

sensor_fft_results.mat

🔹 Helper – Save All Figures

File: save_all_figures.m

Automatically saves all open MATLAB figures as:

results/figure_1.png
results/figure_2.png
...
results/figure_10.png


No need to manually save anything.

📊 List of Figures Generated

You will get these plots:

Module 1

Clean Temperature

Clean Humidity

Combined plot (dual axis)

Module 2

Temperature: True vs Noisy

Humidity: True vs Noisy

Module 3

Temperature: Filters comparison

Humidity: Filters comparison

Kalman Filter result

Module 4

Temperature: Prediction

Humidity: Prediction

Module 5

Temperature FFT

Humidity FFT

(You may number them differently but total ≈10–12 figures.)

📌 Technologies Used

MATLAB R2020+

DSP Concepts:

FIR Filtering

IIR Filtering

Kalman Filtering

AR Modeling

FFT & Frequency Domain Analysis

📝 Future Improvements

Build a simple MATLAB GUI for interactive filtering

Add anomaly detection using prediction residuals

Add multi-sensor fusion (Kalman 2-D or 3-D)

Deploy model to an IoT microcontroller

🏁 Conclusion

This project connects Signals & Systems concepts with Computer Science + IoT applications.
It shows how practical sensor data can be cleaned, analyzed, and predicted using DSP techniques.

🙌 Author

Your Name
B.Tech CSE (Major), EC Minor
NITK Surathkal