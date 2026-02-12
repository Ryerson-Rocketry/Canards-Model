%% Rocket body

lRef = 0.131; %meters
aRef = 0.014; %m^2

rocketLength = 2.68; % Meters

B_CP = 0;
B_CG = 142.25/100;

% TODO: Need to import thrust values from thrust curve file
%% Nosecone 
%Nosecone diameter
NC_dBase = 0.131;
NC_dTop = 0; %Might need to change

%Nosecone areas
NC_aBase = pi*(NC_dBase/2)^2;
NC_aTop = pi*(NC_dTop/2)^2;
NC_aPlan =  0.03355206;
NC_VOL = 0.00019539354;

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


SF_mC = atan2((SF_SA+(SF_TC-SF_RC)/2)/SF_H); % Eq from chatgpt verify!

SF_plan = ((SF_TC+SF_RC)/2)*SF_H;

SF_AR = (SF_H^2)/SF_plan;

%% Canards

