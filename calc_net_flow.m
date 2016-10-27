function [res, net_flow_interior, net_flow_walls] = calc_net_flow(U, T_outside, solar_intensity, window_area, time_index)
    % import static variables
    variables;
    U_int = U(1);
    U_walls_int = U(2);
    U_walls_ext = U(3);
    
    % Calculate flow through windows and sun tube
    solar_angle = 0; % TODO Implement this
    
    T_int = calc_temp_from_u(m_int, C_air, U_int);
    T_ext_walls = calc_temp_from_u(m_walls_ext, C_w, U_walls_ext);
    T_int_walls = calc_temp_from_u(m_walls_int, C_w, U_walls_int);
    
    % Calculate individual flows
    outside_to_ext_walls_flow = convection_ext_walls(T_outside, U_walls_ext);
    sun_to_ext_walls_flow = radiation_flow(Aw, solar_intensity);
    ext_to_int_walls = conduction_walls(T_ext_walls, T_int_walls);
    int_walls_to_int = convection_int_walls(T_int_walls, T_int);
    windows_flow = flow_windows(window_area, T_outside, T_int, solar_intensity, solar_angle);
    
    
    % Calculate net flows
    net_flow_ext_walls = outside_to_ext_walls_flow - ext_to_int_walls;
    % net_flow_ext_to_int_walls = ext_to_int_walls
    net_flow_interior = windows_flow;
    
    plot(time_index/2, ext_to_int_walls, 'bo');
    plot(time_index/2, net_flow_ext_walls, 'ko');
    plot(time_index/2, net_flow_interior, 'go');
    %legend('Wall Conduction', 'External Wall Convection', 'Internal Wall Convection');
    
    res = [net_flow_interior; ext_to_int_walls; net_flow_ext_walls];
end