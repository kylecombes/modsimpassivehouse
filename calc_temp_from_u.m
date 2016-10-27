function res = calc_temp_from_u(m, C, U)
    res = U ./ (m * C); %m*c = heat capacity
end