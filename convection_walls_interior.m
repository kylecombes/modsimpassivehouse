function res = convection_walls_interior(U_walls, U_int)

    variables;
    
    T_walls = calc_temp_from_u(m_walls, C_w, U_walls); % calc wall temp
    T_int = calc_temp_from_u(m_int, Ci, U_int);       % calc interior temp
    res = hw1*Aw*(T_walls - T_int); %flow into interior from walls
    
end