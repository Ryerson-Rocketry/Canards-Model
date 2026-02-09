function [Cn, Cp] = aeroBodyCalcs(mach, alpha, area_bot, area_aft, area_planform, length, volume, x_cp, Aref)
    
    %Normal force coefficent
    body_lift = 1.1 * (area_planform/Aref) * sin(alpha)^2;

    % Need to add limits
    %Open rocket method for calculating the coeff of normal force
    Cn = ((2 * (area_aft - area_bot) * sin(alpha))/(Aref*alpha)) + body_lift; 
   
    %open rocket method for calculating the moment coeff prob not needed
    %C_m_1 = 2 * (length * area_aft - volume) * sin(alpha); waterloo


    Cp = x_cp;
end