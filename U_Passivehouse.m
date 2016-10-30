%function res = U_Passivehouse()

    daysToRunFor = 1;
    double_data_times = 6;

    % Half hours is the number of 30-minute periods that have
    % elapsed since the beginning of that day
    [Months, Days, HalfHours, Solar_direct, Solar_diffuse, ...
        Temp] = import_data(2015);
    
    for n = 1:double_data_times
        if (n < 2)
            endIndex = daysToRunFor*48;
        else
            endIndex = length(Months);
        end
        Months = doubleDataByInterpolation(Months(1:endIndex));
        Days = doubleDataByInterpolation(Days(1:endIndex));
        HalfHours = doubleDataByInterpolation(HalfHours(1:endIndex));
        Solar_direct = doubleDataByInterpolation(Solar_direct(1:endIndex));
        Solar_diffuse = doubleDataByInterpolation(Solar_diffuse(1:endIndex));
        Temp = doubleDataByInterpolation(Temp(1:endIndex));
    end
    
    % initial internal temperature (K)
    global T_int_init T_ext_wall_init
    T_int_init = 290;
    T_ext_wall_init = Temp(1);
    % Load static values
    variables;
    
    % Plots for debugging
%     figure(2);
%     clf
%     xlabel('Time (hours)');
%     ylabel('Heat flow (W)');
%     title('Flows into the system');
%     figure(1);
    clf
    windowAreas = [10];
    subplot(3,1,1);
    hold on
    labels = cell(size(windowAreas));
    
    pointsToCalc = length(Months);
    U_init = [U_int_init U_ext_wall_init];
    for out = 0
    for i = 1:length(windowAreas)
        A_windows = windowAreas(i);
        timeSpan = linspace(0, daysToRunFor*60*60*24, pointsToCalc);
        totalSolar = Solar_diffuse(1:pointsToCalc) + Solar_direct(1:pointsToCalc);
        [Times, U, TDs] = forward_euler(@calc_net_flow, timeSpan, Temp, ...
            totalSolar, A_windows, U_init, out);
        U_int = U(:,1);
        U_walls_ext = U(:,2);
        % Plot internal temperature every run
        T_int = calc_temp_from_u(m_int, C_air, U_int)*(9/5)-459.67;
        Times = Times/(60*60*24);
        plot(Times, T_int);
        labels{i} = strcat('Interior, 10m^2, out: ',num2str(out));
    end
    end
    % Calculate temperatures and convert to F
    T_ext_wall = calc_temp_from_u(m_walls_ext, C_w, U_walls_ext)*(9/5)-459.67;
    T_outside = Temp*(9/5)-459.67;
    % Plot temperatures over time
    %figure(1);
    %times = (1:pointsToCalc)/48;
    plot(Times, T_outside(1:pointsToCalc), 'b--');
    %plot(times, T_ext_wall);
    legend([labels {'Outside Air'}]);
    xlabel('Time (Days)');
    ylabel('Temperature (F)');
    title('House Temperature');
    
    subplot(3,1,2);
    plot(Times, TDs*(9/5));
    xlabel('Time (Days)');
    ylabel('Temperature Difference');
    
    subplot(3,1,3);
    plot(Times, totalSolar,'r');
    xlabel('Time (Days)');
    ylabel('Solar Intensity (W/m^2)');
    title('Solar Intensity');
%end