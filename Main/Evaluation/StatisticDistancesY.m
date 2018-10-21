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
    indx=[];
    yRed=[];
    for m =1:29
        Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesY{m+1,3});
        Amount=int2str(numel(Values));
        y=[y;double(nanmedian(Values))];
        smo = smoothdata(Values,'gaussian',20);
        xp = transpose(1:numel(Values));
        med = nanmedian(smo);
        %Gets new index
        indx = [indx;GetBestImageIndex(xp,smo,med)];
        %% Figure for each Distance
        if drawFigures==true
        figP =figure('visible','off');
        xp = transpose(1:numel(Values));
        plot(xp,Values,xp,smo);
        hold on;
        plot([0 numel(Values)],[median(smo) median(smo)]);
        saveas(figP,strcat('D:\Studienarbeit\ProgrammFolder\Result\Left\',selectedValues{i},filesep,int2str(m),'.png'));
        end
    end
        medindx = median(indx);
    for m =1:29
     ValuesReduced = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesY{m+1,3});
     ValuesReduced = ValuesReduced(medindx-15:medindx+14);
        yRed=[yRed;double(nanmean(ValuesReduced))];
    end
    
% Minimum = Minimum-yMedian;
% Maximum = Maximum-yMedian;
% PlotData= [yMedian,Minimum,Maximum];
%PlotData=sortrows(PlotData,1,'descend');
%app.Distances.(selectedValues{i}).ResultsX(2,2) = {PlotData};
app.Distances.(selectedValues{i}).ResultLeft = y;
app.Distances.(selectedValues{i}).ResultLeftReduced = yRed; 
fig = figure('visible','off');
%errorbar(x,yMedian(:,1),PlotData(:,2),PlotData(:,3));
plot(x,y,x,yRed);
legend({'Full Set','Reduced Set'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
title(['Left Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Result\Left\',selectedValues{i},filesep,'Final.png'));
end
%% ==========================================================================================================================
if Side =="Right"
    x=transpose(1:1:29);
    y=[];
    stder=[];
    Minimum=[];
    Maximum=[];
    Amount='';
        indx=[];
    yRed=[];
    %labels={};
    for m =1:29
        Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesY{m+1,7});
        smo = smoothdata(Values,'gaussian',20);
        Amount=int2str(numel(Values));
        y=[y;double(nanmean(Values))];
        smo = smoothdata(Values,'gaussian',20);
        xp = transpose(1:numel(Values));
        med = nanmedian(smo);
        %Gets new index
        indx = [indx;GetBestImageIndex(xp,smo,med)];
        
        %% Figure for each Distance
                if drawFigures==true
        figP =figure('visible','off');
        xp = transpose(1:numel(Values));
        plot(xp,Values,xp,smo);
        hold on;
        plot([0 numel(Values)],[median(smo) median(smo)]);
        saveas(figP,strcat('D:\Studienarbeit\ProgrammFolder\Result\Right\',selectedValues{i},filesep,int2str(m),'.png'));
                end
    end

        medindx = median(indx);
    for m =1:29
     ValuesReduced = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesY{m+1,7});
     ValuesReduced = ValuesReduced(medindx-15:medindx+14);
        yRed=[yRed;double(nanmean(ValuesReduced))];
    end
app.Distances.(selectedValues{i}).ResultRight = y;
app.Distances.(selectedValues{i}).ResultRightReduced = yRed; 
fig = figure('visible','off');
%errorbar(x,yMedian(:,1),PlotData(:,2),PlotData(:,3));
plot(x,y,x,yRed);
legend({'Full Set','Reduced Set'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');

title(['Right Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Result\Right\',selectedValues{i},filesep,'Final.png'));
end
    function refinedValues= RemoveOutliers(Input)
        InterQRange = iqr(Input);
        p = prctile(Input, [25 75]);
        Input(Input <= p(1)-iqrFactor*InterQRange) = [];
        Input(Input >= p(2)+iqrFactor*InterQRange) = [];
        refinedValues =Input;
    end
end



