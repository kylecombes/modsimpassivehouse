%function res = U_Passivehouse()
    variables;
    
    dUdt = @(ti, Ui) calc_net_flow(ti, Ui, T_outside);
    [times, U] = ode45(dUdt, [start_time, end_time], U_int_init);
    Temps = calc_temp_from_u(m, Ci, U);
    figure(1); clf;
    plot(times, Temps)
    xlabel('Time of Day (Hours)');
    ylabel('Internal Temperature (K)');
    title('House Temperature Throughout the Day');
%end