function res = calc_net_flow(time, U, T_outside)
    
    U_int = U(1);
    U_walls = U(2);
    
    % Calculate flow through windows and sun tube
    solar_angle = 0; % TODO Implement this
    window_area = 6; % (m^2) TODO Change
    solar_intensity = get_solar_intensity(time);
    
    windows = flow_windows(window_area, T_outside, U_int, solar_intensity, solar_angle);
    
    global m Ci U_walls
    % Calculate flow through walls, door, etc.
    T_int = calc_temp_from_u(m, Ci, U_int);
    walls_to_interior_flow = convection_walls_interior(T_int);
    outside_to_walls_flow = convection_exterior_walls(
    walls =  - Convection_outsideH;
    
    net_flow_walls = ;
    net_flow_interior = walls_to_interior_flow;
    
    res = [net_flow_walls; net_flow_interior];
end