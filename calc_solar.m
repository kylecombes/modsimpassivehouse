function [I, theta] = calc_solar(times)
    variables; % import variables
    
    hours_of_day = mod(times, 24); % calculates the remainder, i.e. the
                                 % hour of the current day
    indices_to_keep = (hours_of_day > hours_of_daylight/2).*(hours_of_day < 24 - hours_of_daylight/2); % initialize blank vector
    hours_of_day = hours_of_day - 6; % shift hours_of_day so sun starts rising at 6am
    hours_of_day = hours_of_day .* indices_to_keep; % set all nighttime hours to zero intensity
    
    %% set intensity for daylight hours
    I = hours_of_day*max_solar_intensity;
    
    %% calculate angle of incident, where theta is -1 at sunrise,
    % 0 at noon, and 1 at sunset
    theta = cos(hours_of_day*pi/hours_of_daylight);
end