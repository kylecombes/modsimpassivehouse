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