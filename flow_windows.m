function res = flow_windows(area, temp_diff, solar_intensity, solar_angle, include_outflow)
% FLOW_WINDOWS  Calculates the net flow of energy into the system (in W).

    % Import variables
    variables;

    %% ----- Calculate flow in -----
    % Calculate effective (tangiential) window area
    %area = area * sin(solar_angle);
    % Account for reflection
    %solar_intensity = calc_effective_intensity(solar_intensity, solar_angle);
    
    % Calculate influx
    in = area * solar_intensity/4; % Divide by 3.9 right now since sun is only directly hitting one side at a time
    
    %% ----- Calculate flow out -----
    U_factor = 0.46; % W/m^2*K, source: Home Depot
    out = temp_diff * area * U_factor;
    
    if (include_outflow)
        res = in - out;
    else
        res = in;
    end
    
end