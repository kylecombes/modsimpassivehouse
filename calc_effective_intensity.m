function res = calc_effective_intensity(solar_intensity, theta)
    percent_thru = 0.00525*theta + 0.4475;
    res = solar_intensity * percent_thru;
end