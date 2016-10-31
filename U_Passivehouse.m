%function res = U_Passivehouse()

    startDay = 1;
    endDay = 15;

    % Half hours is the number of 30-minute periods that have
    % elapsed since the beginning of that day
    global HalfHours Solar_direct Solar_diffuse Outside_temp
    [Months, Days, HalfHours, Solar_direct, Solar_diffuse, ...
        Outside_temp] = import_data(2015);
    
    % initial internal temperature (K)
    global T_int_init T_ext_wall_init dt
    dt = 0.5; % time between calculations (hours)
    T_int_init = 280;
    T_ext_wall_init = Outside_temp(1);
    % Load static values
    variables;
    
    clf
    A_windows = 0;
    sun_tube_areas = [1 3];
    subplot(2,1,1);
    hold on
    labels = cell(size(sun_tube_areas));
    
    pointsToCalc = length(Months);
    U_init = [U_int_init U_ext_wall_init];
    for i = 1:length(sun_tube_areas)
        s_a = sun_tube_areas(i);
        timeSpan = startDay*24:dt:endDay*24;
        timePoints = length(timeSpan);
        dUdt = @(ti,Ui) calc_net_flow(ti, Ui, A_windows, s_a);
        [Times, U] = ode45(dUdt, timeSpan, U_init);
        U_int = U(:,1);
        U_walls_ext = U(:,2);
        % Plot internal temperature every run
        T_int = calc_temp_from_u(m_int, C_air, U_int)*(9/5)-459.67;
        Times = Times/24;
        plot(Times, T_int);
        labels{i} = strcat('Interior: ',num2str(s_a),'m^2');
    end
    indexSpan = startDay*24/dt:endDay*24/dt;
    totalSolar = Solar_diffuse(indexSpan) + Solar_direct(indexSpan);
    % Calculate temperatures and convert to F
    T_ext_wall = calc_temp_from_u(m_walls_ext, C_w, U_walls_ext)*(9/5)-459.67;
    % Plot temperatures over time
    %figure(1);
    %times = (1:pointsToCalc)/48;
    plot(Times, Outside_temp(indexSpan)*(9/5)-459.67, 'b--');
    %plot(times, T_ext_wall);
    legend([labels {'Outside Air'}]);
    xlabel('Day of Year');
    ylabel('Temperature (F)');
    title('House Temperature');
    
    subplot(2,1,2);
    plot(Times, totalSolar,'r');
    xlabel('Day of Year');
    ylabel('Solar Intensity (W/m^2)');
    title('Solar Intensity');
%end