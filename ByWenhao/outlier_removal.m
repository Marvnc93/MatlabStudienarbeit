function[distance_after_outlier_removal] = outlier_removal(input_distance)
% [distance_after_outlier_removal] = outlier_removal(input_distance)
% This function removes outliers through boxplot method

distance_after_outlier_removal = [];

for i = 1:size(input_distance,1)
    distance = input_distance(i,:);
    distance_temp = sort(distance,'ascend');
    
    % calculate the lower and upper quartiles
    Q_1 = distance_temp(round(0.25*length(distance_temp)));
    Q_3 = distance_temp(round(0.75*length(distance_temp)));
    
    % define the interquartile range
    IQR = Q_3-Q_1;
    
    % outlier removal when data are 1.5*interquartile range distant from
    % the lower or upper quartiles
    outliers = find((distance<Q_1-1.5*IQR) | (distance>Q_3+1.5*IQR));
    distance_no_outliers = distance;
    distance_no_outliers(outliers) = [];
    distance_no_outliers = [distance_no_outliers,zeros(1,length(distance)-length(distance_no_outliers))];
    distance_after_outlier_removal = [distance_after_outlier_removal;distance_no_outliers];
end

end
