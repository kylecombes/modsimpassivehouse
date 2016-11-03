function [Times, U_int] = import_me_data(tube_area)
    f = strcat('calced-data-3\sola-',num2str(tube_area),'m2.csv');
    data = importdata(f);
    Times = data(1,:);
    U_int = data(2,:);
end