% Shared constants for passive house system and surroundings

% House dimensions
house_length = 6;   % Length of outside (m)
house_width = 2.6;  % Width of house (m)
house_height = 4;   % Height of house (m)
wall_height = 5/8 * house_height; % only walls
wall_area = wall_height * house_width * 4;
roof_angle = 30;
roof_hypot = (house_height-wall_height) / sin(roof_angle*pi/180);
roof_area = roof_hypot * house_length * 2;

% Simulation parameters
%start_time = 0;
%end_time = 240;
global target_temp
target_temp = 294;

% Weather/environment variables
%max_solar_intensity = 1000; % (W/m^2)
%hours_of_daylight = 12; % hours of sunlight per day (hours)

% Various formula variables
% Heat transfer coefficients
Ri = 0.13; %thermal resistivity of inside wall surface
Row = 0.04; %thermal resistivity of outside wall surface
k_int_wall = 1/Ri; %surface conductance inside wall (inverse of Ri)
k_ext_wall = 1/Row; %surface conductance of outside wall (inverse of Row)
k_wood = 0.16; %thermal conductivity of hardwood for walls (W/m*K)
h_c_int_air = 10; % convection coefficient of interior air (W/m^2*K)
h_c_outside_air = 150; % convection coefficient of outside air (W/m^2*K)
r_insul = 27.9; % R-value of 16" of insulation (m^2*K/W)
d_wood = 0.0254; %thickness (m) of single layer of hardwood walls in meters (1 inch)
% Thermal resistance of walls (m^2*K/W)
%       cond int & ext walls | insulation | convection at int & ext walls
R_walls_roof = 2*d_wood/k_wood + r_insul + 1/h_c_int_air + 1/h_c_outside_air;
% Specific heats
C_air = 1005; %specific heat air (J/kg*K)
C_w = 1600; % wood (J/kg*K)

% Masses
m_int = 8000; % mass of interior (kg)
m_walls_ext = 700;  % mass of exterior walls (kg)

% Initial values
global T_int_init T_ext_wall_init
U_int_init = m_int * C_air * T_int_init; %initial internal energy
U_ext_wall_init = m_walls_ext * C_w * T_ext_wall_init; % set initial wall energy, assuming T
                                    % is the same as the interior
