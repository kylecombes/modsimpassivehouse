function res = therm_resistance_walls
	variables; % import static variables
    
    therm_resistance_wall_layer = 1/((1/Ri)+(X1/K1)+(X2/K2)+(1/Row)); %thermal resistance coefficient walls
    res = Aw*therm_resistivity*(T_ext_wall-T_int_wall); %flow
end