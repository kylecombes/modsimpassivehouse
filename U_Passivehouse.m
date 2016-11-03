%function res = U_Passivehouse()

    startDay = 1;
    endDay = 365;
    
    % Half hours is the number of 30-minute periods that have
    % elapsed since the beginning of that day
    [Months, Days, HalfHours, Solar_direct, Solar_diffuse, ...
        Outside_temp] = import_data(2015);
    
    % Create variables object with model constants and simulation
    % parameters
    vars = modelvariables(HalfHours, Solar_direct, Solar_diffuse, Outside_temp);

    clf
    sun_tube_areas = [2];
    subplot(2,1,1);
    hold on
    labels = cell(size(sun_tube_areas));
    
    U_init = [vars.U_int_init vars.U_ext_wall_init];
    for i = 1:length(sun_tube_areas)
        s_a = sun_tube_areas(i);
        vars.sun_tube_area = s_a;
        timeSpan = [startDay endDay]*24;
        timePoints = length(timeSpan);
        options = odeset('MaxStep', 0.05);
        dUdt = @(ti,Ui) calc_net_flow(ti, Ui, vars, s_a);
        [Times, U] = ode45(dUdt, timeSpan, U_init);
        U_int = U(:,1);
        U_walls_ext = U(:,2);
        % Plot internal temperature every run
        T_int = calc_temp_from_u(vars.m_int, vars.C_air, U_int)*(9/5)-459.67;
        Times = Times/24;
        plot(Times, T_int);
        labels{i} = strcat('Interior: ',num2str(s_a),'m^2');
%         maxT = max(T_int);
%         minT = min(T_int);
%         plot([Times(1) Times(end)], [maxT maxT], 'r--');
%         plot([Times(1) Times(end)], [minT minT], 'b--');
        csvwrite(strcat('calced-data-3\sola-',num2str(s_a),'m2.csv'), [Times'; U']);
    end
    indexSpan = (startDay-1)*48+1:endDay*48;
    daySpan = indexSpan/48;
    totalSolar = vars.solar_diffuse(indexSpan) + vars.solar_direct(indexSpan);
    % Calculate temperatures and convert to F
    %T_ext_wall = calc_temp_from_u(m_walls_ext, C_w, U_walls_ext)*(9/5)-459.67;
    % Plot temperatures over time
    %figure(1);
    %times = (1:pointsToCalc)/48;
    plot(daySpan, vars.outside_temps(indexSpan)*(9/5)-459.67, 'k--');
    %plot(times, T_ext_wall);
    legend([labels {'Maximum Temp' 'Minimum Temp' 'Outside Air'}]);
    xlabel('Day of Year');
    ylabel('Temperature (F)');
    title('House Temperature');
    
    subplot(2,1,2);
    plot(daySpan, totalSolar,'r');
    xlabel('Day of Year');
    ylabel('Solar Intensity (W/m^2)');
    title('Solar Intensity');
%end