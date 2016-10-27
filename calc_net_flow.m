function [res, net_flow_interior, net_flow_walls] = calc_net_flow(U, T_outside, solar_intensity, time_index)
    
    U_int = U(1);
    U_walls = U(2);
    
    % Calculate flow through windows and sun tube
    solar_angle = 0; % TODO Implement this
    window_area = 6; % (m^2) TODO Change
    
    windows_flow = flow_windows(window_area, T_outside, U_int, solar_intensity, solar_angle);
    figure(2);
    hold on
    plot(time_index, windows_flow, 'rx');
    if (time_index > 10)
        x = 8;
    end
    
    % Calculate flow through walls, door, etc.
    walls_to_interior_flow = convection_walls_interior(U_walls, U_int);
    plot(time_index, walls_to_interior_flow, 'bo');
    
    outside_to_walls_flow = convection_exterior_walls(T_outside, U_walls);
    plot(time_index, walls_to_interior_flow, 'ko');
    
    net_flow_walls = outside_to_walls_flow - walls_to_interior_flow;
    net_flow_interior = walls_to_interior_flow + windows_flow;
    
    res = [net_flow_interior; net_flow_walls];
end