function res = flow_sun_tubes(tube_area, solar_intensity, temp_diff, include_outflow)

%% Calculate flow in
I = 1.4767*solar_intensity - 9.8*temp_diff + 22;
in = I * tube_area;

%% Calculate flow out
out = 0.63*tube_area*temp_diff/2;

if (include_outflow)
    res = in - out;
else
    res = in;
end
end