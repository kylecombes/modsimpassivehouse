function res = calc_direct_window_irradiation(index, vars, direct_irradiation, window_area)
    time_of_day = vars.times_half_hours(index);
    if (time_of_day < 6 || time_of_day > 18)
        res = 0;
    else
        % Cosine calculates effective (tangiential) window area
        res = abs(cos(0.265258*(time_of_day-6))*direct_irradiation*window_area);
    end
end
