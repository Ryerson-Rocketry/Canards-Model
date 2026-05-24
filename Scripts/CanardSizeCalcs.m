% Calculates time to null a 2 Hz roll rate using canard lift.
% Uses subsonic and supersonic lift coefficient models.
% Reads trajectory data from: Data/Argus_finalFlight.csv

clear; clc; close all;

%% Constants
I = 0.053628;                 % Roll moment of inertia, kg*m^2
R = 287.05;                   % Air gas constant, J/(kg*K)

targetRollHz = 4;             
targetRollRate = 2*pi*targetRollHz;   % rad/s

%% Canard Geometry
gen = 25;                     % deg

Lambda = deg2rad(90 - gen);   % sweep angle, rad
sweep = gen;                  % deg

span = 18.5/1000;               % m
side = span / tand(sweep);
chord = side / 2;             % m

S = span * chord;             % planform area, m^2
AR = span^2 / S;              % aspect ratio

dCent = 0.0655 + (span/3);    % moment arm, m

alpha = deg2rad(10);          % canard angle of attack, rad

cosLam = cos(Lambda);

%% Read Flight Data
data = readtable('Data/Argus_finalFlight.csv');

time = data.x_Time_s_;
v    = data.TotalVelocity_m_s_;
temp = data.AirTemperature_K_;
p    = data.AirPressure_Pa_;
M    = data.MachNumber___;


%% Atmosphere
rho = p ./ (R .* temp);       % kg/m^3
dynPress = 0.5 .* rho .* v.^2;

%% Preallocate
CL = zeros(size(M));


%% Basic Flight Data Info

[max_v, idx_v] = max(v);
[max_M, idx_M] = max(M);
[max_q, idx_q] = max(dynPress);

fprintf('--- Flight Data Summary ---\n');
fprintf('Max Velocity: %.2f m/s at t = %.2f s\n', max_v, time(idx_v));
fprintf('Max Mach: %.2f at t = %.2f s\n', max_M, time(idx_M));
fprintf('Max Dynamic Pressure (MaxQ): %.2f Pa at t = %.2f s\n\n', max_q, time(idx_q));
%% Calculate Lift Coefficient
for k = 1:length(M)

    if M(k) < 1
        % Subsonic: Hembold equation

        denom = 1 + sqrt(1 + (((AR/2) * cosLam)^2) * ...
            (1 - (M(k)^2) * cosLam^2)^2);

        CL(k) = (pi * AR / denom) * alpha;

    else
        % Supersonic: swept subsonic-leading-edge equation

        sigma = acos(1 / M(k));

        if k > 1 && abs(cot(sigma)) < 1e-9
            CL(k) = CL(k-1);
        else
            m = cot(Lambda) / cot(sigma);
            a = m * (0.38 + 2.26*m - 0.86*m^2);

            CL(k) = ((2*pi^2*cot(Lambda)) / (pi + a)) * alpha;
        end
    end
end

%% Lift, Moment, and Angular Acceleration
L = dynPress .* S .* CL;      % N

rollM = L .* dCent;           % N*m

angAccel = rollM ./ I;        % rad/s^2
angAccelDeg = rad2deg(angAccel);

%% Time to Null Target Roll Rate
time_to_target = targetRollRate ./ angAccel;

% Remove bad values
time_to_target(~isfinite(time_to_target)) = NaN;
time_to_target(time_to_target < 0) = NaN;

% Ignore low-speed / low-authority points
valid = v > 20 & dynPress > 50 & angAccel > 1e-6;

time_to_target(~valid) = NaN;
L(~valid) = NaN;
rollM(~valid) = NaN;
angAccel(~valid) = NaN;
angAccelDeg(~valid) = NaN;
CL(~valid) = NaN;

%% Find Minimum Time to Null Roll Rate
[min_time, idx] = min(time_to_target, [], 'omitnan');

fprintf('\nMinimum time to null %.1f Hz roll rate: %.4f s\n', targetRollHz, min_time);
fprintf('Occurs at flight time: %.4f s\n', time(idx));
fprintf('Mach number: %.4f\n', M(idx));
fprintf('Velocity: %.4f m/s\n', v(idx));
fprintf('Dynamic pressure: %.4f Pa\n', dynPress(idx));
fprintf('CL: %.4f\n', CL(idx));
fprintf('Lift: %.4f N\n', L(idx));
fprintf('Roll moment: %.4f N*m\n', rollM(idx));
fprintf('Angular acceleration: %.4f rad/s^2\n', angAccel(idx));
fprintf('Angular acceleration: %.4f deg/s^2\n\n', angAccelDeg(idx));

%% Plot Lift and Angular Acceleration
figure;

yyaxis left
plot(time, L, 'LineWidth', 1.5);
ylabel('Lift (N)');

yyaxis right
plot(time, angAccelDeg, 'LineWidth', 1.5);
ylabel('Angular Acceleration (deg/s^2)');

xlabel('Time (s)');
title('Canard Lift and Roll Angular Acceleration');
legend('Lift', 'Angular Acceleration');
grid on;
xlim([0 25]);

%% Plot Lift Coefficient
figure;
plot(time, CL, 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('C_L');
title('Lift Coefficient vs Time');
grid on;
xlim([0 25]);

%% Plot Lift and Time to Null Roll Rate (same plot)
figure;

yyaxis left
plot(time, L, 'LineWidth', 1.5);
ylabel('Lift (N)');

yyaxis right
plot(time, time_to_target, 'LineWidth', 1.5);
ylabel('Time to Null Roll Rate (s)');

xlabel('Time (s)');
title(['Lift and Time to Null ', num2str(targetRollHz), ' Hz Roll Rate']);
legend('Lift', 'Time to Null');
grid on;
xlim([0 25]);
ylim([0 10]);   % keeps plot readable


