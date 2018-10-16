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
    [jsonNX,jsonNY]=drawNarrow(x,i,0,250*resolution,Dist,userdist.X.(selectedValues{i}).narrow.*resolution,userdist.Y.(selectedValues{i}).right .*resolution,resolution);
    [jsonBX,jsonBY]=drawBroad(x,i,0,350*resolution,Dist,userdist.X.(selectedValues{i}).broad.*resolution,userdist.Y.(selectedValues{i}).left .*resolution,resolution);
    JSON = strcat('{"JSONNX":',jsonNX,',"JSONNY":',jsonNY,',"JSONBX":',jsonBX,',"JSONBY":',jsonBY,'}');
    path = strcat('D:\Studienarbeit\ProgrammFolder\Final\','JSON',convertCharsToStrings(selectedValues(i)),'.json');
    fid = fopen( path, 'w' ); %// open file to writing
fprintf( fid, '%s', JSON ); %// print string to file
fclose( fid ); %// don't forget to close the file

end
close all;

function [jsonX,jsonY]=drawNarrow(x,i,ymin,ymax,Dist,distX,distY,resolution)
selectedValues = fieldnames(Dist);
% DistancesX = Dist.(selectedValues{i}).ResultsX{2,1}(:,1);
% DistancesY = Dist.(selectedValues{i}).ResultsY{2,2}(:,1);
DistancesX=[];
DistancesY=[];
for j=2:30
    DistancesX = [DistancesX,Dist.(selectedValues{i}).DistancesX{j,4}];
end
for j=2:30
    DistancesY = [DistancesY,Dist.(selectedValues{i}).DistancesY{j,8}];
end
% Apply resolution
DistancesX = DistancesX .*resolution;
DistancesY = DistancesY .*resolution;
%% Figure for Box Plots
figBox = figure('Position',[10 10 1000 500],...
    'visible','off');
subplot(1,2,1);
boxplot(DistancesX,'symbol',' ');
title("Narrow Side captured in X-Direction");
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
subplot(1,2,2);
boxplot(DistancesY,'symbol',' ');
title("Narrow Side captured in Y-Direction");
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
%% Figure for Distances Plots
figDist = figure('Position',[10 10 1000 500],...
    'visible','off');
plot(x,nanmedian(DistancesX),x,nanmedian(DistancesY),x,distX,'g-',x,distY);
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
jsonX = jsonencode(median(DistancesX));
jsonY = jsonencode(median(DistancesY));
title("Mean of Both directions");
legend({'X-Direction','Y-Direction','X-User','Y-User'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
saveas(figBox,strcat('D:\Studienarbeit\ProgrammFolder\Final\','Narrow_',convertCharsToStrings(selectedValues(i)),'_Box.png'));
saveas(figDist,strcat('D:\Studienarbeit\ProgrammFolder\Final\','Narrow_',convertCharsToStrings(selectedValues(i)),'_Dist.png'));
end
function [jsonX,jsonY]=drawBroad(x,i,ymin,ymax,Dist,distX,distY,resolution)
global Wenhao;
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
jsonX = jsonencode(median(DistancesX));
jsonY = jsonencode(median(DistancesY));
%% Figure Box Plots
figBox = figure('Position',[10 10 1000 500],...
    'visible','off');
subplot(1,2,1);
boxplot(DistancesX,'symbol',' ');
title("Broad Side captured in X-Direction");
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
subplot(1,2,2);
boxplot(DistancesY,'symbol',' ');
title("Broad Side captured in Y-Direction");
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
%% Figure Distance Plots
figDist = figure('Position',[10 10 1000 500],...
    'visible','off');
plot(x,median(DistancesX),x,nanmedian(DistancesY),x,nandistX,'g-',x,distY,x,Wenhao);
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
title("Mean of Both directions");
legend({'X-Direction','Y-Direction','X-User','Y-User'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
saveas(figBox,strcat('D:\Studienarbeit\ProgrammFolder\Final\','Broad_',convertCharsToStrings(selectedValues(i)),'_Box.png'));
saveas(figDist,strcat('D:\Studienarbeit\ProgrammFolder\Final\','Broad_',convertCharsToStrings(selectedValues(i)),'_Dist.png'));
end


% %% For errorbar
% Results = [Dist.(selectedValues{i}).ResultsX,Dist.(selectedValues{i}).ResultsY];
% %    {["Narrow" ]}    {["Broad"  ]}    {["Left"   ]}    {["Right"  ]}
% %    {29×3 single}    {29×3 single}    {29×3 single}    {29×3 single}
% % Narrow <-> Right Broad <->Left
%
% % Narrow Cell Side
% [nXdist,nXmin,nXmax] = normDistAndErr(Results{2,1}(:,1),Results{2,1}(:,2),Results{2,1}(:,3));
% [nYdist,nYmin,nYmax] = normDistAndErr(Results{2,4}(:,1),Results{2,4}(:,2),Results{2,4}(:,3));
% % Broad Cell Side
% [bXdist,bXmin,bXmax] = normDistAndErr(Results{2,2}(:,1),Results{2,2}(:,2),Results{2,2}(:,3));
% [bYdist,bYmin,bYmax] = normDistAndErr(Results{2,3}(:,1),Results{2,3}(:,2),Results{2,3}(:,3));
%
% fig = figure;
% subplot(1,2,1);
% errorbar(x,nXdist,nXmin,nXmax);
% hold on;
% plot(x,nYdist);
% subplot(1,2,2);
% errorbar(x,bXdist,bXmin,bXmax);
% hold on;
% plot(x,bYdist);
%


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