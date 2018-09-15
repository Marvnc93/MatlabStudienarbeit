function  StatisticDistances(app,selectedValues,drawFigures,stepsForFigures,i,Side)
%STATISTICDISTANCES Summary of this function goes here
%   Detailed explanation goes here
if Side =="Narrow"
    x=transpose(1:1:28);
    y=[];
    stder=[];
    Amount='';
    %labels={};
    for m =1:28
        Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{m+1,3});
        Amount=int2str(numel(Values));
        y=[y;double(mean(Values))];
        stder=[stder;std(Values)];
    end
fig = figure('visible','on');
errorbar(x,y,stder);
title(['Narrow Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
end
if Side =="Broad"
    x=transpose(1:1:28);
    y=[];
    stder=[];
    Amount='';
    %labels={};
    for m =1:28
        Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{m+1,7});
        Amount=int2str(numel(Values));
        y=[y;double(mean(Values))];
        stder=[stder;std(Values)];
    end
fig = figure('visible','on');
errorbar(x,y,stder);
title(['Broad Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
end
%if Side == "Broad"
%plot(x,y);
%The interquartile range is often used to find outliers in data.
%Outliers here are defined as observations that fall below Q1 ? 1.5 IQR or above Q3 + 1.5 IQR.
%text(x,y,labels);
    function refinedValues= RemoveOutliers(Input)
        InterQRange = iqr(Input);
        p = prctile(Input, [25 75]);
        Input(Input <= p(1)-1.5*InterQRange) = [];
        Input(Input >= p(2)+1.5*InterQRange) = [];
        refinedValues =Input;
    end
end

