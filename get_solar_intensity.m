function [times, intensity] = get_solar_intensity()
    
   times = linspace(0,pi,50); % create vector of 100 values between 0 and pi
   x = sin(times); % calculate a sine curve based on those x values
   intensity = [x zeros(1,50)]; % fill in the second half of the sine curve with
                                % zeros to simulate nighttime
    
end