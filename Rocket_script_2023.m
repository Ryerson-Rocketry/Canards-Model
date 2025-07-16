roll = readmatrix("2023_RocketData\GyroRollRate_TeleMega_2024.txt");
pitch = readmatrix("2023_RocketData\GyroPitchRate_TeleMega_2024.txt");
yaw = readmatrix("2023_RocketData\GyroYawRate_TeleMega_2024.txt");

thrust = readmatrix("2023_RocketData\ThrustCurve.txt");

%Rocket body dimensions 

% Nose cone:
% Ogive, Length 23 in, base diam: 4.11 in
% Base fins: root chord: 8in, tip chord: 4 in, height: 3.2in, sweep Length:
% 2.011, sweep angle: 32.1, thickness: 0.118


% Top fins: root chord: 5in, tip chord: 2 in, height: 3.5in, sweep Length:
% 4, sweep angle: 58, thickness: 0.118

% Length of body tube 144 in