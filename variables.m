% All the shared static final (i.e. unchanging) variables for
% the passive house system and surroundings go here.
roof_hypot;
house_length = 6;   % Length of outside (m)
house_width = 2.6;  % Width of house (m)
house_height = 4;   % Height of house (m)
wall_height = 5/8 * house_height; % only walls
roof_hypot = 3/8 * house_height * sqrt(2); % Assume 45 degree roof angle

% Simulation parameters
start_time = 0;
end_time = 240;

% Weather/environment variables
max_solar_intensity = 1000; % (W/m^2)
hours_of_daylight = 12; % hours of sunlight per day (hours)

% Various formula variables
% Heat transfer coefficients
Ri = 0.13; %thermal resistivity of inside wall surface
Row = 0.04; %thermal resistivity of outside wall surface
Ciw = 1/Ri; %surface conductance inside wall (inverse of Ri)
Cow = 1/Row; %surface conductance of outside wall (inverse of Row)
K1 = 0.16; %thermal conductivity of hardwood for walls
K2 = 0.1; %thermal conductivity of insulation
X1 = 0.0254; %thickness of hardwood in meters (1 inch)
X2 = 0.1016; %thickness of insulation meters (4 inches)i
% Specific heats
C_air = 1005; %specific heat air (J/kg*K)
C_w = 1600; % wood (J/kg*K)
% House dimensions
Lw = 6;  %length of wall (m)
Ww = 2.6; %width of wall(m)
Hw = 4; %height of wall (m)
Aw = 34.4; %area of walls
% Masses
m_int = 500; %mass of interior (Kg)
m_walls = 4000; % mass of exterior house (kg)

% Initial values
T_int_init = 295; % initial internal temperature (K)
U_int_init = m_int * C_air * T_int_init; %initial internal energy
U_walls_init = m_walls * C_w * T_int_init; % set initial wall energy, assuming T
                                    % is the same as the interior

