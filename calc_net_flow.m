function [res, net_flow_interior, net_flow_walls] = calc_net_flow(U, T_outside, solar_intensity, time_index)
    % import static variables
    variables;
    U_int = U(1);
    U_walls_int = U(2);
    U_walls_ext = U(3);
    
    % Calculate flow through windows and sun tube
    solar_angle = 0; % TODO Implement this
    window_area = 6; % (m^2) TODO Change
    
    windows_flow = flow_windows(window_area, T_outside, U_int, solar_intensity, solar_angle);
    figure(2);
    hold on
    %plot(time_index, windows_flow, 'rx');
    if (time_index > 10)
        x = 15;
    end
    
    % Calculate flow to interior wall
    T_int = calc_temp_from_u(m_int, C_air, U_walls_int);
    
    %walls_to_interior_flow = convection_walls(T_int, U_walls_int);
    
    outside_to_walls_flow = convection_exterior_walls(T_outside, U_walls_int);
    
    net_flow_walls = outside_to_walls_flow - walls_to_interior_flow;
    net_flow_interior = walls_to_interior_flow + windows_flow;
    
    plot(time_index, net_flow_walls, 'bo');
    plot(time_index, net_flow_interior, 'ko');
    
    res = [net_flow_interior; net_flow_walls];
end