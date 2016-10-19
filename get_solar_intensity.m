function res = get_solar_intensity(time)
    hour_of_day = mod(time, 24); % calculates the remainder, i.e. the
                                 % hour of the current day
    if (hour_of_day < 6 || hour_of_day > 18) % nighttime before 6am and after 6pm
        res = 0;
    else
        shifted_to_sun = hour_of_day - 6; % shift so 6am corresponds to x=0 on the sin curve
        res = sin(shifted_to_sun*pi/12);
    end
end