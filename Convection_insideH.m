function res = Convection_insideH(Tc)

    global hw1 Aw T_outside
    res = hw1*Aw*(T_outside - Tc); %convection inside house
    
end