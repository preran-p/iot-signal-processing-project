# IoT Sensor Signal Processing – Noise Reduction, Prediction & FFT Analysis

Signals and Systems (EC Minor Project)    

---

## 1. Project Overview

This MATLAB project simulates IoT environmental sensor data (temperature and humidity), adds realistic noise, and applies digital signal processing techniques to clean, analyse, and predict the signals.

Main tasks:

- Model clean temperature and humidity signals.
- Add Gaussian noise, spikes, and drift.
- Apply FIR, IIR, and Kalman filtering.
- Select the best filter based on MSE.
- Perform AR(1) prediction.
- Analyse signals using FFT.
- Save all results and figures.

---

## 2. Repository Structure

```text
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
```

- `data/` stores intermediate `.mat` files.  
- `results/` stores all generated figures.

---

## 3. How to Run the Project

### 1️⃣ Clone the repository

```bash
git clone https://github.com/<your-username>/<your-repo-name>.git
cd <your-repo-name>
```

### 2️⃣ Open MATLAB  
Set the MATLAB **Current Folder** to the repo.

### 3️⃣ Run all modules

```matlab
run_all_modules
save_all_figures
```

This will:

- Generate all figures  
- Save `.mat` files into `data/`  
- Save `.png` figures into `results/`  

### Run a specific module

```matlab
module1_signal_modeling
module2_noise_addition
module3_filtering
module4_prediction
module5_fft_analysis
```

---

## 4. Module Descriptions

### 🔹 Module 1 — Sensor Modelling
Generates clean temperature and humidity signals.

**Outputs:**
- Clean plots -  figure_1.png, figure_2.png
- `sensor_true_signals.mat`

---

### 🔹 Module 2 — Noise Addition
Adds Gaussian noise, spikes, and drift.

**Outputs:**
- Noisy signal plots - figure_3.png, figure_4.png
- `sensor_noisy_signals.mat`

---

### 🔹 Module 3 — Filtering (FIR, IIR, Kalman)
Applies:

- FIR moving average  
- IIR exponential smoothing  
- Kalman filter  

Selects best filter using MSE.

**Outputs:**
- Comparison plots - figure_5.png, figure_6.png
- `sensor_filtered_signals.mat`

---

### 🔹 Module 4 — AR(1) Prediction

Uses the AR(1) model:

`x_hat[n] = a * x[n-1]`

where

`a = ( Σ x[n] * x[n-1] ) / ( Σ x[n-1]^2 )`

**Outputs:**
- Actual vs predicted plots - figure_7.png, figure_8.png
- `sensor_prediction_results.mat`

---

### 🔹 Module 5 — FFT Analysis
Removes DC, computes FFT, and normalizes the spectrum.

- DC (mean) is subtracted before FFT so the 0 Hz peak does not dominate.
- Only the 0 to Fs/2 range is plotted and magnitudes are normalised to [0, 1] for clear comparison.

**Outputs:**
- Normalised FFT plots - figure_9.png, figure_10.png
- `sensor_fft_results.mat`


---

## 5. Figures Generated

- Clean signals  
- Noisy vs true  
- Filter comparison  
- Kalman filter output  
- AR prediction  
- FFT of true, noisy, filtered signals  

All saved inside `results/`.

---

## 6. Requirements

- MATLAB R2020a or newer  
- No extra toolboxes needed  

---

## 7. Author

B.Tech EC Minor  
NITK Surathkal  

---
