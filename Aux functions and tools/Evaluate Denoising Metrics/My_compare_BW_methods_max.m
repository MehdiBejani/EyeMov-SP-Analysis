function T = My_compare_BW_methods_max(metric_struct)
%   A function that gets the metrics struct such as SNR and 
%   compare the BW removing methods based on that metric
a= (struct2table (metric_struct));
a1 = (a(:, 2:end));
A = table2array(a1);
Columns = a1.Properties.VariableNames'; % Get columns names from A
max_values = max(A, [], 2) == A;
count_T = sum(max_values);
T = table(Columns, count_T');
end
