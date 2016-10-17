function res = calc_net_flow(time, U_int, T_outside)
    
    % Calculate flow through windows and sun tube
    solar_angle = 0; % TODO Implement this
    window_area = 6; % (m^2) TODO Change
    solar_intensity = get_solar_intensity(time);
    
    windows = flow_windows(window_area, T_outside, U_int, solar_intensity, solar_angle);
    
    global m Ci
    % Calculate flow through walls, door, etc.
    T_int = calc_temp_from_u(m, Ci, U_int);
    walls = Convection_insideH(T_int) - Convection_outsideH;
    
    res = windows + walls;
end