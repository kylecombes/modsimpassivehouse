function res = conduction_walls(T_ext_wall, T_int_wall)
	variables; % import static variables
    
    therm_resistivity = 1/((1/Ri)+(X1/K1)+(X2/K2)+(1/Row)); %thermal resistance coefficient walls
    res = Aw*therm_resistivity*(T_ext_wall-T_int_wall); %flow
end