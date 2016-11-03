function res = flow_windows(index, vars, solar_direct, solar_diffuse, exposed_area, temp_outside, temp_diff)
% FLOW_WINDOWS  Calculates the net flow of energy into the system (in W).

    

    %% ----- Calculate flow in -----
    % Calculate influx
    in_effective_direct = calc_direct_window_irradiation(index, vars, solar_direct, exposed_area/4);
    in_diffuse = vars.exterior_area * solar_diffuse;
    in = in_diffuse + in_effective_direct;
    
    target_temp = 294;
    % Close tubes based temp diff
    if (temp_outside > target_temp || temp_diff < 10)
        in = in*0.1; % Assume closing shutter blocks 90% of heat
    end

    %% ----- Calculate flow out -----
    U_factor = 0.46; % W/m^2*K, source: Home Depot
    out = -temp_diff * vars.exterior_area * U_factor;
    
    res = in - out;
    
end