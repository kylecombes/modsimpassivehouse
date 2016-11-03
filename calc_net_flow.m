function [res, temp_diff] = calc_net_flow(t, U, vars, sun_tube_area)
    
    U_int = U(1);
    U_walls_ext = U(2);
    
    % Interpolate values from data (t is in hours)
    if (t < 0.5) % Don't make index 0
        index = 1;
    else % Proceed normally
        index = floor(t)*2; % 2 data points per hour
        if (mod(t,1) < 0.5)
            % Before half-hour point in the hour, so take the previous data point
                % for that hour
            index = index-1;
        end
    end
    T_outside = (vars.outside_temps(index+1)+vars.outside_temps(index))/2;
    solar_direct = (vars.solar_direct(index+1) + vars.solar_direct(index))/2;
    solar_diffuse = (vars.solar_diffuse(index+1)+vars.solar_diffuse(index))/2;
    total_solar = solar_direct + solar_diffuse;
    
    T_int = calc_temp_from_u(vars.m_int, vars.C_air, U_int);
    T_ext_walls = calc_temp_from_u(vars.m_walls_ext, vars.C_w, U_walls_ext);
    temp_diff = T_outside - T_int;
    
    % Calculate individual flows
    outside_to_ext_walls_flow = convection_ext_walls(T_outside, T_ext_walls, vars.exterior_area);
    ext_wall_to_int = (T_ext_walls - T_int)/vars.R_walls_roof*vars.exterior_area;
    sun_to_roof_flow = radiation_flow(vars.roof_area/2, total_solar);
    sun_to_ext_walls_flow = radiation_flow(vars.effective_wall_area/4, solar_diffuse) ...
        + calc_direct_window_irradiation(index, vars, solar_direct, vars.effective_wall_area/4);
    windows_flow = flow_windows(index, vars, solar_direct, solar_diffuse, vars.window_area/4, T_outside, temp_diff);
    sun_tube_flow = flow_sun_tubes(sun_tube_area, total_solar, T_outside, temp_diff);
     
    % Calculate net flows
    net_flow_ext_walls = outside_to_ext_walls_flow - ext_wall_to_int + sun_to_roof_flow + ...
        sun_to_ext_walls_flow - ext_wall_to_int;
    net_flow_int = ext_wall_to_int + windows_flow + sun_tube_flow;
    % net_flow_ext_to_int_walls = ext_to_int_walls
    %net_flow_interior = windows_flow;
    
    % Should we open the windows?
    target_temp = 294;
    if (T_int > target_temp && T_outside < T_int)
        % Open the windows!!
        ventilation_flow = calc_ventilation_flow(temp_diff, vars.window_area, vars.air_speed);
        net_flow_int = net_flow_int + ventilation_flow;
    end
    
    if (abs(net_flow_int) > 1e20)
        debugme = 'please';
    end
    %plot(time_index/2, ext_to_int_walls, 'bo');
    %plot(time_index/2, net_flow_ext_walls, 'ko');
    %plot(time_index/2, net_flow_interior, 'go');
    %legend('Wall Conduction', 'External Wall Convection', 'Internal Wall Convection');
    res = [net_flow_int; net_flow_ext_walls]*60*30;
    temp_diff = -temp_diff; % Make relative to house temp for plotting
end