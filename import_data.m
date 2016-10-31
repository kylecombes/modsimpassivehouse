function [months, days, halfHours, dni, dhi, temp] = import_data(year)
    f = strcat('solar_data\1321407_42.25_-71.22_',num2str(year),'.csv');
    data = importdata(f);
    months = data.data(:,2);
    days = data.data(:,3);
    halfHours = data.data(:,4)*2 + data.data(:,5)/30;
    dhi = data.data(:,6);
    dni = data.data(:,7);
    temp = data.data(:,8)+273.15;
end