function res = convection_ext_walls(T_outside,T_walls, area)
    res =20*area*(T_outside - T_walls); %flow to exterior walls from outside
end