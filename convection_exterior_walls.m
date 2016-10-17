function res = convection_exterior_walls
global hw1 Aw T_outside m_walls Cw U_walls
    T_walls = calc_temp_from_u(m_walls, Cw, U_walls);
    res = hw1*Aw*(T_outside - T_walls); %convection outside house
end