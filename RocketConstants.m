%% Rocket body

dRef = 0.131; %meters
aRef = 0.014; %m^2


rocketLength = 2.68; % Meters

B_CP = 0.1;
B_CG = 142.25/100;
B_l = 2.04;

B_plan = dRef * B_l;

% TODO: Need to import thrust values from thrust curve file

% thrust_data.m for M1419 motor
t = [0 0.1 0.2 1.4 2.5 3 3.6 4.4 5.8 6.1 6.5 6.9 7];
T = [0 1307.13 1218.53 1373.59 1462.23 1440.04 1404.63 1160.84 664.66 629.17 177.25 8.9 0];
t(end) = 7;
T(end) = 0;
thrust_ts = timeseries(T, t);

%% Nosecone 
%Nosecone diameter
NC_dBase = 0.131;
NC_dTop = 0; %Might need to change

%Nosecone areas
NC_aBase = pi*(NC_dBase/2)^2;
NC_aTop = pi*(NC_dTop/2)^2;
NC_aPlan =  0.03355206;
NC_VOL = 0.00019539354;
NC_L = 0.508;

NC_CP = 57.899/100;
NC_CG = 59.693/100;



%% Static fins

SF_RC = 0.318;
SF_TC = 0.122;
SF_SL = 0.196;
SF_SA = 1.01; %Rads
SF_H = 0.122;
SF_tct = 0.686/100;

SF_CG = 253.464/100;

SF_CP_Sub = 247.563/100;

SF_CP_ts = 248.258/100; %Find better number 

SF_CP_sup = 252/100; %Find better number


SF_mC = atan((SF_SA+(SF_TC-SF_RC)/2)/SF_H); % Eq from chatgpt verify!

SF_plan = ((SF_TC+SF_RC)/2)*SF_H;

SF_AR = (SF_H^2)/SF_plan;

%% Canards

CR_AR = 0;
CR_mC = 0;
CR_Plan = 0;
CR_pos = 0;