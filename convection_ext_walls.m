function res = convection_ext_walls(T_outside,T_walls, area)
    variables;
    res =20*area*(T_outside - T_walls); %flow into interior from walls
end