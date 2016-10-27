function res = flow_windows(area, T_out, U_int, solar_intensity, solar_angle)
% FLOW_WINDOWS  Calculates the net flow of energy into the system (in W).

    % Import variables
    variables;

    %% ----- Calculate flow in -----
    % Calculate effective (tangiential) window area
    %area = area * sin(solar_angle);
    % Account for reflection
    %solar_intensity = calc_effective_intensity(solar_intensity, solar_angle);
    
    % Calculate influx
    in = area * solar_intensity;
    
    %% ----- Calculate flow out -----
    U_factor = 0.29; % W/m^2*K, source: Home Depot
    T_int = calc_temp_from_u(m_int, C_air, U_int);
    out = (T_int - T_out) * area * U_factor;
    
    res = in - out;
    
end