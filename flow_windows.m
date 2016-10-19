function res = flow_windows(area, T_out, U_int, solar_intensity, solar_angle)
% FLOW_WINDOWS  Calculates the net flow of energy into the system (answer
% in W).


    % calculate flow in
    in = area * solar_intensity;
    
    % calculate flow out
    global m_int Co
    T_int = calc_temp_from_u(m_int, Co, U_int);
    e = 0.9;                    % emissivity of house interior (percentage)
    sigma = 5.6703 * 10^-8;   % Stefan-Boltzmann constant (W/m^2*K^4)
    out = e * sigma * T_int^4;
    
    res = in - out;
    
    %function res = intensity_thru_window(intensity, angle)
        
    %end
end