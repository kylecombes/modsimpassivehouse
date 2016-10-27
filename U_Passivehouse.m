%function res = U_Passivehouse()
    variables;
    % Half hours is the number of 30-minute periods that have
    % elapsed since the beginning of that day
    [Months, Days, HalfHours, Solar_direct, Solar_diffuse, ...
        Temp] = import_data(2015);
    
    % Plots for debugging
    figure(2);
    clf
    xlabel('Time (hours)');
    ylabel('Heat flow (J)');
    title('Flows into the system');
    figure(1);
    clf
    
    halfHourPeriodsToCalc = 5*48;
    U_init = [U_int_init U_walls_init U_walls_init];
    U_int = zeros(halfHourPeriodsToCalc,1);
    U_walls_int = zeros(halfHourPeriodsToCalc,1);
    U_walls_ext = zeros(halfHourPeriodsToCalc,1);
    for m = 1 % months to calculate
        for d = 1:5 % days to calculate
            indexStart = ((monthDayToDayOfYear(m,d)-1) * 48) + 1;
            indexEnd = indexStart + 47;
            indexSpan = indexStart:indexEnd;
            totalSolar = Solar_diffuse + Solar_direct;
            [Times, U] = forward_euler(@calc_net_flow, indexSpan, Temp, totalSolar, U_init);
            U_int(indexStart:indexEnd) = U(:,1);
            U_walls_int(indexStart:indexEnd) = U(:,2);
            U_walls_ext(indexStart:indexEnd) = U(:,3);
            U_init = [U_int(indexEnd) U_walls_int(indexEnd) U_walls_ext(indexEnd)];
        end
    end
    Temps = calc_temp_from_u(m_int, C_air, U_walls_int);
    figure(1);
    subplot(2,1,1);
    times = (1:halfHourPeriodsToCalc)/48;
    TempsF = Temps*(9/5)-459.67; % Convert K to F
    plot(times, TempsF);
    legend('Interior');
    xlabel('Time (Days)');
    ylabel('Temperature (F)');
    title('House Temperature');
    
    x = linspace(start_time, end_time, length(times)*2);
    [I, theta] = calc_solar(x);
    subplot(2,1,2);
    plot(x,theta,'r');
    xlabel('Time (Hours)');
    ylabel('Solar Intensity (W/m^2)');
    title('Solar Intensity');
%end