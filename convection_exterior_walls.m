function res = convection_exterior_walls(U_walls, U
global hw2 Aw T_outside m_walls Cw Co
    T_walls = calc_temp_from_u(m_walls, Cw, U_walls);
    T_ext = calc_temp_from_u(m_
    %%
    % 
    %   for x = 1:10
    % 
    %  PREFORMATTED
    %  TEXT
    % 
    %       disp(x)
    %   end
    flow = hw1*Aw*(T_walls - T_outside);
    res = [-flow; flow; %convection outside house
end