function res = convection_exterior_walls(T_outside, U_walls)
	variables; % import static variables
    T_walls = calc_temp_from_u(m_walls, C_w, U_walls);
    res = hw1*Aw*(T_outside - T_walls); %convection outside house
end