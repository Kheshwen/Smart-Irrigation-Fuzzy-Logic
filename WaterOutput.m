clear; clc; close all; 

% Construct FIS
SmartIrrigationControlSystem = mamfis(Name="SmartIrrigationControlSystem");

% Input 1: Soil Moisture (0% to 100%)
SmartIrrigationControlSystem = addInput(SmartIrrigationControlSystem, [0 100], Name="SoilMoisture");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "SoilMoisture", "trapmf", [0 0 25 45], Name="Dry", VariableType="input");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "SoilMoisture", "trimf", [30 50 70], Name="Moist", VariableType="input");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "SoilMoisture", "trapmf", [55 75 100 100], Name="Wet", VariableType="input");

% Input 2: Temperature (0°C to 50°C)
SmartIrrigationControlSystem = addInput(SmartIrrigationControlSystem, [0 50], Name="Temperature");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "Temperature", "trapmf", [0 0 12 22], Name="Cold", VariableType="input");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "Temperature", "trimf", [15 25 35], Name="Normal", VariableType="input");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "Temperature", "trapmf", [28 38 50 50], Name="Hot", VariableType="input");

% Input 3: Humidity (0% to 100%)
SmartIrrigationControlSystem = addInput(SmartIrrigationControlSystem, [0 100], Name="Humidity");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "Humidity", "trapmf", [0 0 25 45], Name="Low", VariableType="input");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "Humidity", "trimf", [30 50 70], Name="Medium", VariableType="input");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "Humidity", "trapmf", [55 75 100 100], Name="High", VariableType="input");

% Output 1: Water Amount (0% to 100%)
SmartIrrigationControlSystem = addOutput(SmartIrrigationControlSystem, [0 100], Name="WaterAmount");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "WaterAmount", "trapmf", [0 0 10 25], Name="Zero", VariableType="output");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "WaterAmount", "trimf", [15 35 55], Name="Low", VariableType="output");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "WaterAmount", "trimf", [45 65 85], Name="Medium", VariableType="output");
SmartIrrigationControlSystem = addMF(SmartIrrigationControlSystem, "WaterAmount", "trapmf", [75 90 100 100], Name="Large", VariableType="output");

% Rules
rulesList = [
    1 1 1 3 1 1; 
    2 1 1 2 1 1; 
    3 1 1 1 1 1; 
    1 2 1 4 1 1; 
    2 2 1 3 1 1; 
    3 2 1 1 1 1; 
    1 3 1 4 1 1; 
    2 3 1 4 1 1; 
    3 3 1 1 1 1; 
    1 1 2 3 1 1; 
    2 1 2 2 1 1; 
    3 1 2 1 1 1; 
    1 2 2 3 1 1; 
    2 2 2 2 1 1; 
    3 2 2 1 1 1; 
    1 3 2 4 1 1; 
    2 3 2 3 1 1; 
    3 3 2 1 1 1; 
    1 1 3 2 1 1; 
    2 1 3 1 1 1; 
    3 1 3 1 1 1; 
    1 2 3 3 1 1; 
    2 2 3 1 1 1; 
    3 2 3 1 1 1; 
    1 3 3 3 1 1; 
    2 3 3 2 1 1; 
    3 3 3 1 1 1  
];

SmartIrrigationControlSystem = addRule(SmartIrrigationControlSystem, rulesList);

% Plot Membership Functions
figure('Name', 'Membership Function Plots');
subplot(2,2,1); plotmf(SmartIrrigationControlSystem, 'input', 1); title('Soil Moisture MFs');
subplot(2,2,2); plotmf(SmartIrrigationControlSystem, 'input', 2); title('Temperature MFs');
subplot(2,2,3); plotmf(SmartIrrigationControlSystem, 'input', 3); title('Humidity MFs');
subplot(2,2,4); plotmf(SmartIrrigationControlSystem, 'output', 1); title('Water Amount MFs');

% Test Case Simulation: Dry Soil (15%), Hot Temp (38°C), Low Humidity (20%)
testInput = [15, 38, 20];
calculatedWater = evalfis(SmartIrrigationControlSystem, testInput);
fprintf('Simulation Test\n');
fprintf(' \n');
fprintf('Input Conditions  : Soil Moisture = %d%%, Temp = %d°C, Humidity = %d%%\n', testInput(1), testInput(2), testInput(3));
fprintf('Controller Output : Water Amount = %.2f%%\n', calculatedWater);

gensurf(SmartIrrigationControlSystem); % Generates 3D Surface View
ruleview(SmartIrrigationControlSystem); % Generates Rule Viewer
