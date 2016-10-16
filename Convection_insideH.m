function res = Convection_insideH(Tc)
variables;

    Cwi = hw*Aw*(T_Outside - Tc); %convection inside house
    res = Cwi;
    
end