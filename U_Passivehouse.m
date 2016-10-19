%function res = U_Passivehouse()
    variables;
    
    dUdt = @(ti, Ui) calc_net_flow(ti, Ui, T_outside);
    options = odeset('RelTol', 1e-1);
    [times, U] = ode45(dUdt, [start_time, end_time], [U_int_init U_walls_init], odeset);
    U_int = U(:,1);
    U_walls = U(:,2);
    Temps = calc_temp_from_u(m_int, Ci, U_int);
    figure(1); clf;
    subplot(2,1,1);
    plot(times, Temps);
    legend('Interior');
    xlabel('Time (Hours)');
    ylabel('Temperature (K)');
    title('House Temperature');
    
    x = linspace(start_time, end_time, length(times)*2);
    [I, theta] = calc_solar(x);
    subplot(2,1,2);
    plot(x,theta,'r');
    xlabel('Time (Hours)');
    ylabel('Solar Intensity (W/m^2)');
    title('Solar Intensity');
%end