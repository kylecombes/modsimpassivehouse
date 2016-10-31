function res = calc_direct_window_irradiation(index, direct_irradiation, window_area)
    global HalfHours
    time_of_day = HalfHours(index);
    if (time_of_day < 6 || time_of_day > 18)
        res = 0;
    else
        res = abs(cos(0.265258*(time_of_day-6))*direct_irradiation*window_area);
    end
end
