clear all; clc;

%% Entire Rocket Body
Argus_Diam = 0.131; %meters
Argus_Area = 0.014; %m^2
Argus_radius = Argus_Diam/2;



%% Sustainer Rocket body
Sustainer_Length = 3.25;
SustainerDryMass = 15;
SustainerWetMass = 31.4;

%% Booster Rocket body
Booster_Length = 4.73;
BoosterDryMass = 9.59;
BoosterWetMass = 26.4;

%% Thrust Data
[boosterCurve, sustainerCurve] = thrustCurves("Data/O5500X.eng", "Data/N4000W.eng");


%% Nosecone
%Nosecone diameter
NC_dBase = 0.131;
NC_dTop = 0; %Might need to change

%Nosecone areas
NC_aBase = pi*(NC_dBase/2)^2;
NC_aTop = pi*(NC_dTop/2)^2;

NC_aPlan =  0.03355206;
NC_VOL = 0.00025723428;
NC_L = 0.381;  

NC_CP = NC_L*0.466;
NC_CG = 0.20388;

%% Canards 
CR_AR = 0;
CR_mC = 0;
CR_Plan = 0;
CR_pos = 0;

%% Sustainer Static Fins
SF_NFins = 4;
SF_RC = 0.318;
SF_TC = 0.122;
SF_SL = 0.196;
SF_SA = 1.01; %Rads
SF_H = 0.122;

sf_yMac = (SF_H/3)*((SF_RC+(2*SF_TC))/(SF_RC+SF_TC));




%% Booster Static Fins