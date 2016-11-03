function res = calc_ventilation_flow(temp_diff, window_area, airspeed)
    density_air = 1.225; % density of air (kg/m^3)
    C_air = 1005; %specific heat air (J/kg*K)
    res = density_air*(window_area/2)*C_air*airspeed*temp_diff;
end