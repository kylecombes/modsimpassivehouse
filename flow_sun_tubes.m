function res = flow_sun_tubes(tube_area, solar_intensity, temp_outside, temp_diff)

%% Calculate flow in
I = 1.4767*solar_intensity - 9.8*temp_diff + 22;
in = I * tube_area;

target_temp = 294;
% Close tubes based temp diff
if (temp_outside > target_temp || temp_diff < 10)
    in = 0;
end

%% Calculate flow out
out = 0.63*tube_area*temp_diff/2;
res = in - out;
end