function res = convection_walls(T_outside,U)
    variables;
    T_walls = calc_temp_from_u(m_walls, C_w, U_walls); % calc wall temp
    
    %T_int = calc_temp_from_u(m_int, Ci, U_int);       % calc interior temp
    res = hw1*Aw*(T_walls - T_int); %flow into interior from walls
    endfunction res = convection_walls_interior(U_int,U)
    T_walls = clac_temp_from_u(m_walls, C_W, U);
end