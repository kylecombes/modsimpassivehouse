function res = flow_windows(index, exposed_area, total_area, temp_diff, solar_direct, solar_diffuse, include_outflow)
% FLOW_WINDOWS  Calculates the net flow of energy into the system (in W).

    % Import variables
    variables;

    %% ----- Calculate flow in -----
    % Calculate effective (tangiential) window area
    %area = area * sin(solar_angle);
    % Account for reflection
    %solar_intensity = calc_effective_intensity(solar_intensity, solar_angle);
    
    % Calculate influx
    %in_direct = calc_direct_window_irradiation(index, solar_direct, exposed_area/4);
    in_diffuse = total_area * solar_diffuse;
    in = in_diffuse;
    
    %% ----- Calculate flow out -----
    U_factor = 0.46; % W/m^2*K, source: Home Depot
    out = -temp_diff * total_area * U_factor;
    
    if (include_outflow)
        res = in - out;
    else
        res = in;
    end
    
end