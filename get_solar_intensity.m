function res = get_solar_intensity(time)
    if (time < 6 || time > 18) % nighttime before 6am and after 6pm
        res = 0;
    else
        time = time - 6; % shift so 6am corresponds to x=0 on the sin curve
        res = sin(time*pi/12);
    end
end