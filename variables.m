% All the shared variables for the passive
% house system and surroundings go here.

global T_outside house_length house_width house_height wall_height roof_hypot
T_outside = 300;    % Temperature outside (K)
house_length = 6;   % Length of outside (m)
house_width = 2.6;  % Width of house (m)
house_height = 4;   % Height of house (m)
wall_height = 5/8 * house_height;
roof_hypot = 3/8 * house_height * sqrt(2); % Assume 45 degree roof angle

% Simulation parameters
global start_time end_time
start_time = 0;
end_time = 24;

% Various formula variables
global hw1 hw2 Lw Ww Hw Aw m Co Ci
hw1 = 10; %heat transfer coefficient of walls and door inside
hw2 = 100; %heat transfer coefficient of walls to outside air
Lw = 6;  %length of wall (m)
Ww = 2.6; %width of wall(m)
Hw = 4; %height of wall (m)
Aw = 34.4; %area of walls
m = 4500; %mass in Kg
Co = 26.85; %specific heat air outside
Ci = 1.4; %specific heat air inside

% Initial values
global T_int_init U_int_init
T_int_init = 20; % initial internal temperature (K)
U_int_init = m * Ci * T_int_init; %initial internal energy

