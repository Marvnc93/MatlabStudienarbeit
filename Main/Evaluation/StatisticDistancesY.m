function  StatisticDistancesY(app,selectedValues,drawFigures,stepsForFigures,i,Side)
%STATISTICDISTANCES Summary of this function goes here
%   Detailed explanation goes here
iqrFactor=1.5;
if Side =="Left"
    x=transpose(1:1:29);
    y=[];
    stder=[];
    Minimum=[];
    Maximum=[];
    Amount='';
    for m =1:29
        Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesY{m+1,3});
        %Values = Values(1:cutOffIndex,1);
        smo = smoothdata(Values,'gaussian',20);
        
        %Values = Values(1:150,:);
        Amount=int2str(numel(Values));
        y=[y;double(nanmean(Values))];
        stder=[stder;std(Values)];
        Minimum=[Minimum;min(Values)];
        Maximum=[Maximum;max(Values)];
        
        %% Figure for each Distance
        if drawFigures==true
        figP =figure('visible','off');
        xp = transpose(1:numel(Values));
        plot(xp,Values,xp,smo);
        hold on;
        plot([0 numel(Values)],[median(smo) median(smo)]);
        saveas(figP,strcat('D:\Studienarbeit\ProgrammFolder\Result\Left\',int2str(i),filesep,int2str(m),'.png'));
        end
    end
    
Minimum = Minimum-y;
Maximum = Maximum-y;
PlotData= [y,Minimum,Maximum];
PlotData=sortrows(PlotData,1,'descend');
app.Distances.(selectedValues{i}).ResultsY(2,1) = {PlotData};
fig = figure('visible','off');
errorbar(x,PlotData(:,1),PlotData(:,2),PlotData(:,3));
title(['Right Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Result\Left\',int2str(i),filesep,'Final.png'));
end
%% 
if Side =="Right"
    x=transpose(1:1:29);
    y=[];
    stder=[];
    Minimum=[];
    Maximum=[];
    Amount='';
    %labels={};
    for m =1:29
        Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesY{m+1,7});
        smo = smoothdata(Values,'gaussian',20);
        Amount=int2str(numel(Values));
        y=[y;double(nanmean(Values))];
        stder=[stder;std(Values)];
        Minimum=[Minimum;min(Values)];
        Maximum=[Maximum;max(Values)];
        
        %% Figure for each Distance
        figP =figure('visible','off');
        xp = transpose(1:numel(Values));
        plot(xp,Values,xp,smo);
        hold on;
        plot([0 numel(Values)],[median(smo) median(smo)]);
        saveas(figP,strcat('D:\Studienarbeit\ProgrammFolder\Result\Right\',int2str(i),filesep,int2str(m),'.png'));
    end
Minimum = Minimum-y;
Maximum = Maximum-y;
PlotData= [y,Minimum,Maximum];
PlotData=sortrows(PlotData,1,'descend');
app.Distances.(selectedValues{i}).ResultsY(2,2) = {PlotData};
fig = figure('visible','off');
errorbar(x,PlotData(:,1),PlotData(:,2),PlotData(:,3));
title(['Right Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Result\Right\',int2str(i),filesep,'Final.png'));
end
    function refinedValues= RemoveOutliers(Input)
        InterQRange = iqr(Input);
        p = prctile(Input, [25 75]);
        Input(Input <= p(1)-iqrFactor*InterQRange) = [];
        Input(Input >= p(2)+iqrFactor*InterQRange) = [];
        refinedValues =Input;
    end
end



