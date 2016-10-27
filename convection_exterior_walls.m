function res = convection_exterior_walls(T_outside,U)
	variables; % import static variables
    
    %global  Aw m_walls Ri X1 K1 X2 K2 Row T_int Ci 
    T_int = calc_temp_from_u(m_walls,C_air,U);
    therm_resistivity = 1/((1/Ri)+(X1/K1)+(X2/K2)+(1/Row)); %thermal resistance coefficient walls
    heat_transfer_thru_walls = Aw*therm_resistivity*(T_int-T_outside); %flow

    flow = heat_transfer_thru_walls;
    res = -flow; 
end