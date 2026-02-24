%Calculates the time to null a 2hz roll rate of a rocket at max dynamic
%pressure, an absolute worse case control requirement
%Variables are the span and chord, change these the know how fast in
%seconds the canards would be able to null that rotation
clear; clc; close all;
% %% Past roll rate data
% 
% % Read space-separated numeric file
% data = readmatrix('/Users/ranvirsingh/Documents/Ryerson University/MetRocketry/CanardsModel/2023_RocketData/GyroRollRate_TeleMega_2024.txt');
% 
% % Assign columns to variables
% timeRoll = data(:,1);
% RollRate = data(:,2);


%% Constants
I = 0.06324;

gen = 27;

Lambda = deg2rad(90-gen);        % sweep angle in radians (quarter-chord sweep if using Eq.6)
sweep = 90-(90-gen);

cosLam = cos(Lambda);




span = 25/1000;              % m
side = span/tand(sweep);
chord = (side/2);      % m  


dCent = 0.0655+(span/3);

alpha = deg2rad(20);          % AoA in radians
wt = 2*pi*2;

% Planform area (now expressed via span & chord)
S = span * chord;            % = 0.5*cr*span

% Aspect ratio (general definition)
AR = span^2 / S;             % = span/chord = 2*span/cr for delta


R = 287.05;

data = readtable('Data/check.csv');
time = data.x_Time_s_;
v    = data.TotalVelocity_m_s_;
temp = data.AirTemperature_K_;
p    = data.AirPressure_Pa_;
M    = data.MachNumber___;

dt = 0.01;


rho  = p ./ (R .* temp);
CL   = zeros(size(M));
L    = zeros(size(M));
rollM = zeros(size(M));
angVel = zeros(size(M));
timeTo = zeros(size(M));
dynPress = zeros(size(M));

for k = 1:length(M)
    denom = 1 + sqrt(1 + (((AR/2) * cosLam)^2) * (1 - (M(k)^2) * cosLam^2)^2);
    CL(k) = (pi * AR / denom) * alpha;

end



% Lift
L = 0.5 .* rho .* (v.^2) .* S .* CL;
dynPress = 0.5 .* rho .* (v.^2);

for rl = 1:length(M)
    rollM(rl) =  L(rl)*dCent;
    angVel(rl) = rollM(rl)/I;
end


time_to_target = wt ./ angVel;

[min_time, idx] = min(time_to_target)

plot(time, L);
xlabel('Time (s)');
ylabel('Lift (N)');
hold on
grid on;
xline(25.795)
xline(6.121)
xline(7.937);
plot(time, angVel);
xlim([0 28])
ylim([0 16])
plot(time, time_to_target);
legend('Lift', 'Ang Vel', 'Time to target')



