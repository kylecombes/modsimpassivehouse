function res = convection_ext_walls(T_outside,U_walls)
    variables;
    T_walls = calc_temp_from_u(m_walls_ext, C_w, U_walls); % calc wall temp
    
    res =0*Aw*(T_outside - T_walls); %flow into interior from walls
end