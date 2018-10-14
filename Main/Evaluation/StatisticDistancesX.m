function  StatisticDistancesX(app,selectedValues,drawFigures,stepsForFigures,i,Side)
%STATISTICDISTANCES Summary of this function goes here
%   Detailed explanation goes here
iqrFactor=1.5;
if Side =="Narrow"
    x=transpose(1:1:29);
    yMean=[];
    yMedian=[];
    stder=[];
    Minimum=[];
    Maximum=[];
    yRed=[];
    stderRed=[];
    MinimumRed=[];
    MaximumRed=[];
    indx = [];
    Amount='';
    cutOffIndexArray=[];
    for o = 1:29
        prepValues = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{o+1,3});
        prepsmo = smoothdata(prepValues,'gaussian',20);
        cutOffIndexArray = [cutOffIndexArray;GetCutoffIndex(prepsmo, "backwards")];
    end
    cutOffIndex = median(cutOffIndexArray);
    %Second Iteration
    cutOffIndexArray=[];
    for o = 1:29
        prepValues = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{o+1,3});
        prepValues = prepValues(1:cutOffIndex,1);
        prepsmo = smoothdata(prepValues,'gaussian',20);
        cutOffIndexArray = [cutOffIndexArray;GetCutoffIndex(prepsmo, "backwards")];
    end
    cutOffIndex = median(cutOffIndexArray);
    for m =1:29
        Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{m+1,3});
        %Values =app.Distances.(selectedValues{i}).DistancesX{m+1,3};
        Values = Values(1:cutOffIndex,1);
        smo = smoothdata(Values,'gaussian',20);
        xp = transpose(1:numel(Values));
        med = nanmedian(smo);
        %Gets new index
         indx = [indx;GetBestImageIndex(xp,smo,med)];
        Amount=int2str(numel(Values));
        yMean=[yMean;double(nanmean(Values))];
        yMedian=[yMedian;double(nanmedian(Values))];
        stder=[stder;std(Values)];
        Minimum=[Minimum;min(Values)];
        Maximum=[Maximum;max(Values)];
        %% Figure for each Distance

        if drawFigures==true
        figP =figure('visible','off');
        %         [h,p,k,c] = lillietest(Values);
%         xp = transpose(1:numel(Values));
%         histfit(Values,20);
%         title(strcat('Hypotheses is rejected: ' ,num2str( h)));
        %Line of best fit
        lobf = polyfit(xp,smo,1);
        plot(xp,Values,xp,smo,xp,xp*lobf(1)+lobf(2));
        hold on;
        plot([0 numel(Values)],[med med]);
        hold on;
        rectangle('Position',[indx(m)-15 med-15 30 30]);
        legend({'Original','Smoothend','LoBF','Median'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
        saveas(figP,strcat('D:\Studienarbeit\ProgrammFolder\Result\Narrow\',selectedValues{i},filesep,int2str(m),'.png'));
                close all;
        end
    end
medindx = median(indx)
for m =1:29
%      Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{m+1,3});
%      Values = Values(medindx-15:medindx+14);
% %         Amount=int2str(numel(Values));
%         yRed=[yRed;double(nanmean(Values))];
%         %yRed=[yRed;double(nanmedian(Values))];
%         stderRed=[stderRed;std(Values)];
%         MinimumRed=[MinimumRed;min(Values)];
%         MaximumRed=[MaximumRed;max(Values)];
end
Minimum = Minimum-yMean;
Maximum = Maximum-yMean;
PlotData= [yMean,Minimum,Maximum];
%%PlotData=sortrows(PlotData,1,'descend');
app.Distances.(selectedValues{i}).ResultsX(2,1) = {PlotData};
fig = figure('visible','off');
plot(x,yMean,x,yMedian);
legend({'Mean','Median'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
%errorbar(x,PlotData(:,1),PlotData(:,2),PlotData(:,3));
%errorbar(y,stder);
title(['Narrow Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Result\Narrow\',selectedValues{i},filesep,'Final.png'));
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
        prepValues = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{o+1,3});
        prepsmo = smoothdata(prepValues,'gaussian',20);
        cutOffIndexArray = [cutOffIndexArray;GetCutoffIndex(prepsmo, "backwards")];
    end
    cutOffIndex = median(cutOffIndexArray);
    for m =1:29
        %Values = RemoveOutliers(app.Distances.(selectedValues{i}).DistancesX{m+1,7});
        Values =app.Distances.(selectedValues{i}).DistancesX{m+1,7};
        Values = Values(cutOffIndex:end,:);
        smo = smoothdata(Values,'gaussian',20);
        Amount=int2str(numel(Values));
        y=[y;double(nanmean(Values))];
        stder=[stder;std(Values)];
        Minimum=[Minimum;min(Values)];
        Maximum=[Maximum;max(Values)];
        
        %% Figure for each Distance
        if drawFigures==true
        figP =figure('visible','off');
        xp = transpose(1:numel(Values));
        lobf = polyfit(xp,smo,1);
        med = median(smo);
        indx = GetBestImageIndex(xp,smo,med);
        plot(xp,Values,xp,smo);%,xp,xp*fsl(1)+fsl(2));
        hold on;
        plot([0 numel(Values)],[med med]);
          hold on;
        rectangle('Position',[indx-15 min(smo) 30 max(smo)-min(smo)]);
        legend({'Original','Smoothend','LoBF','Median'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
        saveas(figP,strcat('D:\Studienarbeit\ProgrammFolder\Result\Broad\',selectedValues{i},filesep,int2str(m),'.png'));
        close all;
        end
    end
    
Minimum = Minimum-y;
Maximum = Maximum-y;
PlotData= [y,Minimum,Maximum];
%PlotData=sortrows(PlotData,1,'descend');
app.Distances.(selectedValues{i}).ResultsX(2,2) = {PlotData};
fig = figure('visible','off');
errorbar(x,PlotData(:,1),PlotData(:,2),PlotData(:,3));
title(['Broad Side ',strrep(selectedValues{i},'_',' '),' used: ',Amount,' Data Points each']);
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Result\Broad\',selectedValues{i},filesep,'Final.png'));
end
    function refinedValues= RemoveOutliers(Input)
        InterQRange = iqr(Input);
        p = prctile(Input, [25 75]);
        Input(Input <= p(1)-iqrFactor*InterQRange) = [];
        Input(Input >= p(2)+iqrFactor*InterQRange) = [];
        refinedValues =Input;
    end
end

