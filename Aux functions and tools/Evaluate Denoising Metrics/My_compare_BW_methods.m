function T = My_compare_BW_methods(metric_struct)
%   A function that gets the metrics struct such as MAD and 
%   compare the BW removing methods based on that metric
a= (struct2table (metric_struct));
a1 = (a(:, 2:end));
A = table2array(a1);
Columns = a1.Properties.VariableNames'; % Get columns names from A
min_values = min(A, [], 2) == A;
count_T = sum(min_values);
T = table(Columns, count_T');
end

