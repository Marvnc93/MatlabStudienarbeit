%Dist = app.Distances;
global Dist;
Dist = load("dist.mat");
load('userdist.mat');
Dist=Dist.dist;
selectedValues = fieldnames(Dist);
%Resulution in 1 px = x µm
resolution = 25;
global Wenhao
Wenhao = [299.09,252.61,233.96,239.03,244.70,253.50,262.27,257.62,262.61,265.12,262.28,263.79,258.95,244.61,218.67,274.46,259.54,257.90,257.75,262.32,269.30,264.28,265.92,...
268.72,266.38,262.42,257.31,247.67,218.67];
Wenhao = Wenhao.* resolution;
x = 1:1:29;



for i=1:length(selectedValues)
drawNarrow(x,i,0,250*resolution,Dist,userdist.X.(selectedValues{i}).narrow.*resolution,userdist.Y.(selectedValues{i}).right .*resolution,resolution);
%drawBroad(x,i,0,350*resolution,Dist,userdist.X.(selectedValues{i}).broad.*resolution,userdist.Y.(selectedValues{i}).left .*resolution,resolution);

end
close all;

function drawNarrow(x,i,ymin,ymax,Dist,distX,distY,resolution)
selectedValues = fieldnames(Dist);
xDist=Dist.(selectedValues{i}).ResultNarrow.*resolution;
xDistred=Dist.(selectedValues{i}).ResultNarrowReduced.*resolution;
yDist=Dist.(selectedValues{i}).ResultRight.*resolution;
yDistred=Dist.(selectedValues{i}).ResultRightReduced.*resolution;


%% Figure for Distances Plots
figDist = figure('Position',[10 10 1000 500],...
    'visible','off');
plot(x,xDist,x,yDist,x,distX,'g-',x,distY,x,xDistred,x,yDistred);
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);

title("Mean of Both directions");
legend({'X-Direction','Y-Direction','X-User','Y-User','X-Reduced','Y-Reduced'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
saveas(figDist,strcat('D:\Studienarbeit\ProgrammFolder\Final\','Narrow_',convertCharsToStrings(selectedValues(i)),'_Dist.png'));
end
function drawBroad(x,i,ymin,ymax,Dist,distX,distY,resolution)
selectedValues = fieldnames(Dist);
DistancesX=[];
DistancesY=[];

for j=2:30
    DistancesX = [DistancesX,Dist.(selectedValues{i}).DistancesX{j,8}];
end
for j=2:30
    DistancesY = [DistancesY,Dist.(selectedValues{i}).DistancesY{j,4}];
end
% Apply resolution
DistancesX = DistancesX .*resolution;
DistancesY = DistancesY .*resolution;

broad = [transpose(nanmedian(DistancesX)),transpose(nanmedian(DistancesY)),distX,distY];
%% Figure Distance Plots
figDist = figure('Position',[10 10 1000 500],...
    'visible','off');
plot(x,nanmedian(DistancesX),x,nanmedian(DistancesY),x,distX,'g-',x,distY,x,Wenhao);
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
title("Mean of Both directions");
legend({'X-Direction','Y-Direction','X-User','Y-User'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
saveas(figBox,strcat('D:\Studienarbeit\ProgrammFolder\Final\','Broad_',convertCharsToStrings(selectedValues(i)),'_Box.png'));
saveas(figDist,strcat('D:\Studienarbeit\ProgrammFolder\Final\','Broad_',convertCharsToStrings(selectedValues(i)),'_Dist.png'));
end



function [outDist,outMin,outMax]=normDistAndErr(dist,MinErr,MaxErr)

mindist = min(dist);
maxdist = max(dist);
diff = maxdist-mindist;
outDist=[];
outMin =[];
outMax =[];

for j=1:length(dist)
    outDist =[outDist;(dist(j)- mindist)/diff];
    outMin = [outMin; MinErr(j)/diff];
    outMax = [outMax;MaxErr(j)/diff];
end



end