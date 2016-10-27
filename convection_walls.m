function res = convection_walls(T_air,U_walls)
    variables;
    T_walls = calc_temp_from_u(m_walls, C_w, U_walls); % calc wall temp
    
    res = Aw*(T_air - T_walls); %flow into interior from walls
end