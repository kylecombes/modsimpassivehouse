%function res = U_Passivehouse()
    variables;
    
    dUdt = @(ti, Ui) calc_net_flow(ti, Ui, T_outside, solar_intensity);
    [times, Y] = ode45(dUdt, [initial_time_index, final_time_index], U_int_init);
        Temp = Y/Hc;
    figure(1); clf;
    plot(times, Temp)
%end       