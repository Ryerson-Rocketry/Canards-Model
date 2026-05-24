clear;
clc;
close all;

% Define transfer function
num = [222];
den = [1 20.86 222];

G = tf(num, den);

% Display it
disp('Transfer Function:');
G

% Step response
figure;
step(G);
grid on;
title('Step Response of G(s) = 222 / (s^2 + 20.86s + 222)');

% Time vector for finer control
t = 0:0.001:1;

% Simulate response
[y, t] = step(G, t);

figure;
plot(t, y, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Output');
title('Step Response (Detailed View)');

% Step response characteristics
info = stepinfo(G);
disp('Step Response Characteristics:');
disp(info);