%function res = U_Passivehouse()
    % Half hours is the number of 30-minute periods that have
    % elapsed since the beginning of that day
    [Months, Days, HalfHours, Solar_direct, Solar_diffuse, ...
        Temp] = import_data(2015);
    % initial internal temperature (K)
    global T_int_init
    T_int_init = Temp(1);
    % Load static values
    variables;
    
    % Plots for debugging
    figure(2);
    clf
    xlabel('Time (hours)');
    ylabel('Heat flow (W)');
    title('Flows into the system');
    figure(1);
    clf
    daysToRunFor = 4;
    
    halfHourPeriodsToCalc = daysToRunFor*48;
    U_init = [U_int_init U_walls_init U_walls_init];
%     U_int = zeros(halfHourPeriodsToCalc,1);
%     U_walls_int = zeros(halfHourPeriodsToCalc,1);
%     U_walls_ext = zeros(halfHourPeriodsToCalc,1);
    %for m = 1 % months to calculate
    for A_windows = 6
        indexStart = 1; %((monthDayToDayOfYear(m,d)-1) * 48) + 1;
        indexEnd = 48*daysToRunFor;
        indexSpan = indexStart:indexEnd;
        totalSolar = Solar_diffuse(1:halfHourPeriodsToCalc) + Solar_direct(1:halfHourPeriodsToCalc);
        [Times, U] = forward_euler(@calc_net_flow, indexSpan, Temp, totalSolar, A_windows, U_init);
        U_int = U(:,1);
        U_walls_int = U(:,2);
        U_walls_ext = U(:,3);
    end
    % Calculate temperatures and convert to F
    T_ext_wall = calc_temp_from_u(m_walls_ext, C_w, U_walls_ext)*(9/5)-459.67;
    T_int_wall = calc_temp_from_u(m_walls_int, C_w, U_walls_int)*(9/5)-459.67;
    T_int = calc_temp_from_u(m_int, C_air, U)*(9/5)-459.67;
    T_outside = Temp*(9/5)-459.67;
    % Plot temperatures over time
    figure(1);
    subplot(2,1,1);
    hold on
    times = (1:halfHourPeriodsToCalc)/48;
    plot(times, T_outside(1:indexEnd), 'b--');
    plot(times, T_ext_wall);
    plot(times, T_int_wall);
    %plot(times, T_int);
    legend('Outside Air', 'Exterior Wall', 'Interior Wall', 'Inside');
    xlabel('Time (Days)');
    ylabel('Temperature (F)');
    title('House Temperature');
    
    subplot(2,1,2);
    plot(times, totalSolar,'r');
    xlabel('Time (Days)');
    ylabel('Solar Intensity (W/m^2)');
    title('Solar Intensity');
%end