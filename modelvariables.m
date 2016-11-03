classdef modelvariables
% Shared constants for passive house system and surroundings
    properties
        % House dimensions
        house_length = 6;   % Length of outside (m)
        house_width = 2.6;  % Width of house (m)
        house_height = 4;   % Height of house (m)
        wall_height;
        effective_wall_area;
        roof_angle = 30;
        roof_hypot;
        roof_area;
        exterior_area;
        window_area = 2;
        sun_tube_area;

        target_temp = 294;
        air_speed = 0.1; % average airspeed through house when windows are open (m/s)
        
        % Various formula variables
        % Heat transfer coefficients
        Ri = 0.13; %thermal resistivity of inside wall surface
        Row = 0.04; %thermal resistivity of outside wall surface
        k_int_wall; %surface conductance inside wall (inverse of Ri)
        k_ext_wall; %surface conductance of outside wall (inverse of Row)
        k_wood = 0.16; %thermal conductivity of hardwood for walls (W/m*K)
        k_insul = 0.16; % thermal conductivity of insulation (W/m*K)
        h_c_int_air = 10; % convection coefficient of interior air (W/m^2*K)
        h_c_outside_air = 150; % convection coefficient of outside air (W/m^2*K)
        r_insul = 42; % R-value of 24" of insulation (m^2*K/W)
        u_sun_tube = 0.82; % U-value of Solatube 160 DSe (W/m^2*K)
        d_wood = 0.0254; %thickness (m) of single layer of hardwood walls in meters (1 inch)
        d_insul = 0.61; % depth of insulation (m)
        % Thermal resistance of walls (m^2*K/W)
        R_walls_roof;
        density_air = 1.225; % density of air (kg/m^3)
        % Specific heats
        C_air = 1005; %specific heat air (J/kg*K)
        C_w = 1600; % wood (J/kg*K)

        % Masses
        m_int = 8000; % mass of interior (kg)
        m_walls_ext = 700;  % mass of exterior walls (kg)

        % Initial values
        U_int_init; %initial internal energy
        U_ext_wall_init; % set initial wall energy, assuming T is the same as the interior
        
        % initial temperatures (K)
        T_int_init = 294;
        T_ext_wall_init;
        
        % Simulation parameters
        times_half_hours;
        solar_direct;
        solar_diffuse;
        outside_temps;
    end
    
    methods
        function obj = modelvariables(times, solarDirect, solarDiffuse, outsideTemps)
            obj.wall_height = 5/8 * obj.house_height; % only walls
            obj.roof_hypot = (obj.house_height-obj.wall_height) / sin(obj.roof_angle*pi/180);
            obj.roof_area = obj.roof_hypot * obj.house_length * 2;
            wall_area = obj.wall_height * obj.house_width * 4;
            obj.effective_wall_area = wall_area - obj.window_area;
            obj.exterior_area = obj.effective_wall_area + obj.roof_area;
            obj.k_int_wall = 1/obj.Ri;
            obj.k_ext_wall = 1/obj.Row;
            % Net R-value walls   cond int & ext walls | insulation | convection at int & ext walls
            obj.R_walls_roof = 2*obj.d_wood/obj.k_wood + obj.r_insul + 1/obj.h_c_int_air + 1/obj.h_c_outside_air;
            obj.U_int_init = obj.m_int * obj.C_air * obj.T_int_init;
            obj.T_ext_wall_init = outsideTemps(1);
            obj.U_ext_wall_init = obj.m_walls_ext * obj.C_w * obj.T_ext_wall_init;
            obj.solar_direct = solarDirect;
            obj.solar_diffuse = solarDiffuse;
            obj.outside_temps = outsideTemps;
            obj.times_half_hours = times;
        end
        
        function obj = set.sun_tube_area(obj, newVal)
            obj.sun_tube_area = newVal;
            obj.exterior_area = obj.exterior_area - newVal;
        end
    end
end