% All the shared static final (i.e. unchanging) variables for
% the passive house system and surroundings go here.

house_length = 6;   % Length of outside (m)
house_width = 2.6;  % Width of house (m)
house_height = 4;   % Height of house (m)
wall_height = 5/8 * house_height;
roof_hypot = 3/8 * house_height * sqrt(2); % Assume 45 degree roof angle

% Simulation parameters
start_time = 0;
end_time = 240;

% Weather/environment variables
max_solar_intensity = 1000; % (W/m^2)
hours_of_daylight = 12; % hours of sunlight per day (hours)

% Various formula variables
% Heat transfer coefficients
hw1 = 10; %heat transfer coefficient of walls and door inside
hw2 = 100; %heat transfer coefficient of walls to outside air
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
m_walls = 4000; % mass of walls (kg)

% Initial values
T_int_init = 295; % initial internal temperature (K)
U_int_init = m_int * C_air * T_int_init; %initial internal energy
U_walls_init = m_walls * C_w * T_int_init; % set initial wall energy, assuming T
                                    % is the same as the interior

