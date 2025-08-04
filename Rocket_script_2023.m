roll = readmatrix("2023_RocketData/GyroRollRate_TeleMega_2024.txt");
pitch = readmatrix("2023_RocketData/GyroPitchRate_TeleMega_2024.txt");
yaw = readmatrix("2023_RocketData/GyroYawRate_TeleMega_2024.txt");

%thrust = readmatrix("2023_RocketData/ThrustCurve.txt");
thrust = readmatrix("2023_RocketData/ThrustCurve2026.txt");






%Rocket body dimensions 

% Nose cone:
% Ogive, Length 23 in, base diam: 4.11 in
% Base fins: root chord: 8in, tip chord: 4 in, height: 3.2in, sweep Length:
% 2.011, sweep angle: 32.1, thickness: 0.118


% Top fins: root chord: 5in, tip chord: 2 in, height: 3.5in, sweep Length:
% 4, sweep angle: 58, thickness: 0.118

% Length of body tube 144 in

%vehicle mass 36.51 kg wet 17.64 dry mmoi 14.57



%2026 rocket dimentions
% Fins: Num Fins: 3
%   Root Chord: 31.8 cm, Tip chord: 12.2 cm, Sweep Angle: 30.8 deg
%   Height: 15.2 cm, sweep length: 9.1 cm, Thickness: 0.686cm
% Nosecone: 
%   Ogive, Length: 38.1 cm, Diameter: 15.7cm <-- Ref length
%   Ref area: 193cm ^2
% General: 
%   Length: 206 cm
%   Dry mass: 19.536
%   Wet mass: 26.452kg
%   MMOI: (based on cylindrical approx) [X,Y]: 6.531914, [Z]: 0.635615
%   Impulse 7680 N-sec



