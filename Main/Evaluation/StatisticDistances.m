function  StatisticDistances(app,selectedValues,drawFigures,stepsForFigures,i,Side)
%STATISTICDISTANCES Summary of this function goes here
%   Detailed explanation goes here
iqrFactor=1.5;
if Side =="Narrow"
    x=transpose(1:1:29);
    y=[];
    stder=[];
    Minimum=[];
    Maximum=[];
    Amount='';
    cutOffIndexArray=[];
    %labels={};
    for o = 1:29
        prepValues = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{o+1,3});
        prepsmo = smoothdata(prepValues,'gaussian',20);
        cutOffIndexArray = [cutOffIndexArray;GetCutoffIndex(prepsmo, "backwards")];
    end
    cutOffIndex = median(cutOffIndexArray);
    for m =1:29
        Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{m+1,3});
        Values = Values(1:cutOffIndex,1);
        smo = smoothdata(Values,'gaussian',20);
        
        %Values = Values(1:150,:);
        Amount=int2str(numel(Values));
        y=[y;double(mean(Values))];
        stder=[stder;std(Values)];
        Minimum=[Minimum;min(Values)];
        Maximum=[Maximum;max(Values)];
        
        %% Figure for each Distance
        if drawFigures==true
        figP =figure('visible','off');
        xp = transpose(1:numel(Values));
        
        plot(xp,Values,xp,smo);
%         hold on;
%         plot([0 numel(Values)],[mean(smo) mean(smo)]);
        hold on;
        plot([0 numel(Values)],[median(smo) median(smo)]);
        saveas(figP,strcat('D:\Studienarbeit\ProgrammFolder\Result\Narrow\',int2str(i),filesep,int2str(m),'.png'));
        end
    end
    
Minimum = Minimum-y;
Maximum = Maximum-y;
fig = figure('visible','off');
errorbar(x,y,Minimum,Maximum);
title(['Narrow Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Result\Narrow\',int2str(i),filesep,'Final.png'));
end
%% 
if Side =="Broad"
    x=transpose(1:1:29);
    y=[];
    stder=[];
    Minimum=[];
    Maximum=[];
    Amount='';
    cutOffIndexArray=[];
    %labels={};
    for o = 1:29
        prepValues = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{o+1,7});
        prepsmo = smoothdata(prepValues,'gaussian',20);
        cutOffIndexArray = [cutOffIndexArray;GetCutoffIndex(prepsmo, "forwards")];
    end
    cutOffIndex = median(cutOffIndexArray);
    if cutOffIndex<100
        cutOffIndex=150;
    end

    for m =1:29
        Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{m+1,7});
        Values = Values(50:end,:);
        smo = smoothdata(Values,'gaussian',20);
        

        Amount=int2str(numel(Values));
        y=[y;double(mean(Values))];
        stder=[stder;std(Values)];
        Minimum=[Minimum;min(Values)];
        Maximum=[Maximum;max(Values)];
        
        %% Figure for each Distance
        figP =figure('visible','off');
        xp = transpose(1:numel(Values));
        
        plot(xp,Values,xp,smo);
%         hold on;
%         plot([0 numel(Values)],[mean(smo) mean(smo)]);
        hold on;
        plot([0 numel(Values)],[median(smo) median(smo)]);
        saveas(figP,strcat('D:\Studienarbeit\ProgrammFolder\Result\Broad\',int2str(i),filesep,int2str(m),'.png'));
    end
    
Minimum = Minimum-y;
Maximum = Maximum-y;
fig = figure('visible','off');
errorbar(x,y,Minimum,Maximum);
title(['Broad Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Result\Broad\',int2str(i),filesep,'Final.png'));
end
    function refinedValues= RemoveOutliers(Input)
        InterQRange = iqr(Input);
        p = prctile(Input, [25 75]);
        Input(Input <= p(1)-iqrFactor*InterQRange) = [];
        Input(Input >= p(2)+iqrFactor*InterQRange) = [];
        refinedValues =Input;
    end
end

