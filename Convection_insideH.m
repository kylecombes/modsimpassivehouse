function res = Convection_insideH(Tc)

    global hw Aw T_outside
    res = hw*Aw*(T_outside - Tc); %convection inside house
    
end