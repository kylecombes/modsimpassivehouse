% function res = analyze_data()

    variables;
    solar_tube_areas = 1:20;
    
    %Map = zeros(length(solar_tube_areas),12);
    max_temp_dev = zeros(1,length(solar_tube_areas));
    figure(1);
    for A = solar_tube_areas
        %figure(A);
        [Times, U_int] = import_me_data(A);
        T_int = calc_temp_from_u(m_int, C_air, U_int)*(9/5)-459.67;
        Times = Times/52;
        %plot(Times, T_int);
        labels{A} = strcat('Interior: ',num2str(A),'m^2');
        %subplot(ceil(length(solar_tube_areas)/2),2,i);
%         figure(3);
%         boxplot(T_int, floor(Times));
%         xlabel('Day of Year');
%         ylabel('Temperature');
%         title('Daily Temperature Fluctuation');
%         figure(4);
%         boxplot(T_int, floor(Times/7));
%         xlabel('Week of Year');
%         ylabel('Temperature');
%         title('Weekly Temperature Fluctuation');
%         figure(5);
        %% Box plots -- temp deviation for each month, fig for each tube area
%         Months = floor(Times/31)+1;
%         maxvariance = zeros(1,12);
%         tempdiff = T_int-70; % calculate diff from target temp
%         abstempdiff = abs(tempdiff);
%         for m = 1:12
%             points = Months==m; % logical array
%             maxdiff = max(abstempdiff(points));
%             maxvariance(m) = maxdiff;
%             Map(i,m) = maxdiff;
%         end
%         boxplot(T_int, Months);
%         xlabel('Month of Year');
%         ylabel('Temperature');
%         title(strcat('Monthly Temperature Fluctuation for Solatube Area=',num2str(A)));
%         X = calc_box_whisker_each_day(Times, T_int);
        
        % Use below for generation of 2D punchline graph
        max_temp_dev(A) = max(abs(T_int-70));
    end
    %% Heat map of time vs tube area vs abs temp deviation
%     figure(16);
%     surf(1:12, solar_tube_areas, Map);
%     view(2);
%     colorbar;
%     xlabel('Month of Year');
%     ylabel(colorbar, 'Temperature Variance (°F)');
%     ylabel('Total Solatube Area (m^2)');
%     %%

    %% Punchline graph of tube area vs max temp deviation
    figure(A+1);
    plot(solar_tube_areas, max_temp_dev(solar_tube_areas));
    xlabel('Solatube® Area');
    ylabel('Maximum Deviation (°F)');
    title('Maximum Deviation from Target Temperature (70°F)');
    
    %% This stuff wasn't ever used
%     function res = calc_box_whisker_each_day(times, temps)
%         curr_day = 1;
%         res = [];
%         for i = 1:length(times)
%             T_one_day = [];
%             while true
%                 t = times(i);
%                 if (floor(t) == curr_day)
%                     T_one_day(length(T_one_day)+1) = temps(i);
%                 else
%                     res(length(res)+1) = [T_one_day'];
%                 end
%             end
%             res(length(res)+1) = T_one_day
%         end
%     end

%     function [meanT, maxT, minT] = calc_mean_max_min(T)
%         maxT = max(T);
%         minT = min(T);
%         meanT = sum(T)/length(T);
%     end
% end