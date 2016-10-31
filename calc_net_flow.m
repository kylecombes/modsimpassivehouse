function [res, temp_diff] = calc_net_flow(t, U, window_area, sun_tube_area)
    % import static variables
    variables;
    
    exterior_area = wall_area+roof_area;
    % Calculate flow through windows and sun tube
    solar_angle = 0; % TODO Implement this
    %window_area = sun_tube_area;
    
    U_int = U(1);
    U_walls_ext = U(2);
    
    % Interpolate values from data (t is in hours)
    global Solar_diffuse Solar_direct Outside_temp
    index = floor(t)*2; % 2 data points per hour
    if (mod(t,1) < 0.5)
        % Before half-hour point in the hour, so take the previous data point
            % for that hour
        index = index-1;
    end
    T_outside = (Outside_temp(index+1)+Outside_temp(index))/2;
    solar_direct = (Solar_direct(index+1) + Solar_direct(index))/2;
    solar_diffuse = (Solar_diffuse(index+1)+Solar_diffuse(index))/2;
    
    T_int = calc_temp_from_u(m_int, C_air, U_int);
    T_ext_walls = calc_temp_from_u(m_walls_ext, C_w, U_walls_ext);
    %T_int_walls = calc_temp_from_u(m_walls_int, C_w, U_walls_int);
    temp_diff = T_outside - T_int;
    
    % Calculate individual flows
    outside_to_ext_walls_flow = convection_ext_walls(T_outside, T_ext_walls, exterior_area);
    ext_wall_to_int = (T_ext_walls - T_int)/R_walls_roof*exterior_area;
    %sun_to_roof_flow = radiation_flow(roof_area/2, solar_intensity);
    %sun_to_ext_walls_flow = radiation_flow(wall_area/4, solar_intensity);
    include_window_outflow = 1;
    windows_flow = flow_windows(index, window_area/4, window_area, temp_diff, solar_direct, solar_diffuse, include_window_outflow);
    sun_tube_flow = flow_sun_tubes(sun_tube_area, solar_direct+solar_diffuse, T_outside, temp_diff, include_window_outflow);
     
    % Calculate net flows
    net_flow_ext_walls = outside_to_ext_walls_flow - ext_wall_to_int;% + sun_to_roof_flow + ...
        %sun_to_ext_walls_flow - ext_wall_to_int;
    net_flow_int = ext_wall_to_int + windows_flow + sun_tube_flow;
    % net_flow_ext_to_int_walls = ext_to_int_walls
    %net_flow_interior = windows_flow;
    
    %plot(time_index/2, ext_to_int_walls, 'bo');
    %plot(time_index/2, net_flow_ext_walls, 'ko');
    %plot(time_index/2, net_flow_interior, 'go');
    %legend('Wall Conduction', 'External Wall Convection', 'Internal Wall Convection');
    if (T_outside > 70 && solar_direct < 10)
        x=6;
    end
    res = [net_flow_int; net_flow_ext_walls]*60*30;
    temp_diff = -temp_diff; % Make relative to house temp for plotting
end