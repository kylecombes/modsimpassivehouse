% All the shared variables for the passive
% house system and surroundings go here.

T_outside = 300;    % Temperature outside (K)
house_length = 6;   % Length of outside (m)
house_width = 2.6;  % Width of house (m)
house_height = 4;   % Height of house (m)
wall_height = 5/8 * house_height;
roof_hypot = 3/8 * house_height * sqrt(2); % Assume 45 degree roof angle

% solar intensity throughout day

[times, solar_intensity] = get_solar_intensity();

[times, solar_intensity] = get_solar_intensity();
initial_time = 0
final_time = 1440*60 %seconds in 24 hours
%T1 = initial temperature
hw1 = 10; %heat transfer coefficient of walls and door inside
hw2 = 100; %heat transfer coefficient of walls to outside air
Lw = 6;  %length of wall (m)
Ww = 2.6; %width of wall(m)
Hw = 4; %height of wall (m)
Aw = 34.4; %area of walls
m = 4535.924; %mass in Kg
Co = 26.85; %specific heat air outside
Ci = 1.4; %specific heat air inside
U1 = m*Ci*T1; %initial internal energy

