function res = convection_int_walls(T_walls, T_int)
    variables;
    tdiff = T_walls - T_int;
    res = 100*Aw*(tdiff); %flow into interior from walls
    
    fprintf('Temp diff at interior wall: %.2i Flow: %.2i\n', tdiff, res);
end