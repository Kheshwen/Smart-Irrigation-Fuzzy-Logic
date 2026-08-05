# 🌱 Fuzzy Logic-Based Smart Irrigation Control System

A MATLAB-based fuzzy inference system (FIS) that determines how much water a plant needs based on **soil moisture**, **temperature**, and **humidity** — built using the Mamdani fuzzy logic model.

![MATLAB](https://img.shields.io/badge/MATLAB-Fuzzy%20Logic%20Toolbox-orange)
![License](https://img.shields.io/badge/license-MIT-blue)

---

## 📖 Overview

Traditional irrigation systems either over-water or under-water plants because they don't account for multiple environmental factors at once. This project uses fuzzy logic to mimic human-like decision-making — combining soil moisture, temperature, and humidity readings to output a smooth, proportional watering amount instead of a rigid on/off response.

## ⚙️ System Design

| Type | Variable | Range | Linguistic Terms |
|------|----------|-------|-------------------|
| Input | Soil Moisture | 0–100% | Dry, Moist, Wet |
| Input | Temperature | 0–50°C | Cold, Normal, Hot |
| Input | Humidity | 0–100% | Low, Medium, High |
| Output | Water Amount | 0–100% | Zero, Low, Medium, Large |

**Inference method:** Mamdani (chosen for interpretability — rules map directly to natural human reasoning)
**Aggregation:** Minimum/Product
**Defuzzification:** Centroid

![FIS Architecture](images/fis_architecture.png)

## 📐 Membership Functions

| Variable | MF | Type | Parameters |
|----------|----|------|------------|
| Soil Moisture | Dry / Moist / Wet | Trap / Tri / Trap | [0 0 25 45] / [30 50 70] / [55 75 100 100] |
| Temperature | Cold / Normal / Hot | Trap / Tri / Trap | [0 0 12 22] / [15 25 35] / [28 38 50 50] |
| Humidity | Low / Medium / High | Trap / Tri / Trap | [0 0 25 45] / [30 50 70] / [55 75 100 100] |
| Water Amount | Zero / Low / Medium / Large | Trap / Tri / Tri / Trap | [0 0 10 25] / [15 35 55] / [45 65 85] / [75 90 100 100] |

![Membership Functions](images/membership_functions.png)

## 📋 Rule Base (27 rules)

A sample of the rule logic (full list in [`WaterOutput.m`](WaterOutput.m)):

| # | Soil Moisture | Temperature | Humidity | → Water Amount |
|---|---------------|-------------|----------|-----------------|
| 1 | Dry | Cold | Low | Medium |
| 4 | Dry | Normal | Low | Large |
| 7 | Dry | Hot | Low | Large |
| 9 | Wet | Hot | Low | Zero |
| 16 | Dry | Hot | Medium | Large |
| 25 | Dry | Hot | High | Medium |
| 27 | Wet | Hot | High | Zero |

## 🖥️ How to Run

1. Requires MATLAB with the **Fuzzy Logic Toolbox**.
2. Clone the repo and open `WaterOutput.m`.
3. Run the script — it will:
   - Build the FIS
   - Plot all membership functions
   - Run a sample simulation
   - Open the 3D surface view and rule viewer

```matlab
run('WaterOutput.m')
```

## 📊 Sample Simulation

**Input:** Soil Moisture = 15%, Temperature = 38°C, Humidity = 20%
**Output:** Water Amount = **90.98%**

This matches expectations — dry soil, hot weather, and low humidity should trigger heavy watering.

![Surface View](images/surface_view.png)

**Rule Viewer** (27 rules, split across 3 images):

![Rule Viewer 1](images/rule_viewer_1.png)
![Rule Viewer 2](images/rule_viewer_2.png)
![Rule Viewer 3](images/rule_viewer_3.png)

## 📁 Repository Structure

```
smart-irrigation-fuzzy-logic/
├── README.md
├── WaterOutput.m
├── SmartIrrigationControlSystem.fis
├── docs/
│   └── Project_Report.pdf
└── images/
    ├── membership_functions.png
    ├── fis_architecture.png
    ├── surface_view.png
    ├── rule_viewer_1.png
    ├── rule_viewer_2.png
    └── rule_viewer_3.png
```

## 👥 Contributors

| Name | Student ID |
|------|------------|
| Kheshwenda A/L Narasimban | 24003160 |
| Anuar Afiq Bin Arfahairy | 24002263 |
| Fawwaz 'Arash Bin Mohamad Fakhri | 24001456 |

## 📄 License

This project is licensed under the MIT License.
