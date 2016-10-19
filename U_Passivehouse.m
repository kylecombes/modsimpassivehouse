%function res = U_Passivehouse()
    variables;
    
    dUdt = @(ti, Ui) calc_net_flow(ti, Ui, T_outside);
    options = odeset('RelTol', 1e-1);
    [times, U] = ode45(dUdt, [start_time, end_time*2], [U_int_init U_walls_init], odeset);
    U_int = U(:,1);
    U_walls = U(:,2);
    Temps = calc_temp_from_u(m_int, Ci, U_int);
    figure(1); clf;
    plot(times, Temps)
    xlabel('Time of Day (Hours)');
    ylabel('Internal Temperature (K)');
    title('House Temperature Throughout the Day');
%end