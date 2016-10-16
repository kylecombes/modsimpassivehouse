function res = U_Passivehouse(T1)
    variables;
    
    
    [T, Y] = ode45(@finalfunc_ph, [initial_time,final_time], U1);
        Temp = Y/Hc;
    figure(1); clf;
    plot(T, Temp)
end

    
       
        
        
        
      
        