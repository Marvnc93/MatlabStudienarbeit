%Dist = app.Distances;
global Dist;
Dist = load("dist.mat");
load('userdist.mat');
Dist=Dist.dist;
selectedValues = fieldnames(Dist);
%Resulution in 1 px = x µm
resolution = 1;

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
fig = figure('Position',[10 10 1000 500],...
    'visible','off');
subplot(1,3,1);
boxplot(DistancesX,'symbol',' ');
title("Narrow Side captured in X-Direction");
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
subplot(1,3,2);
boxplot(DistancesY,'symbol',' ');
title("Narrow Side captured in Y-Direction");
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
subplot(1,3,3);
plot(x,median(DistancesX),x,median(DistancesY),x,distX,'g-',x,distY);
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
jsonX = jsonencode(median(DistancesX));
jsonY = jsonencode(median(DistancesY));
title("Mean of Both directions");
legend({'X-Direction','Y-Direction','X-User','Y-User'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Final\','Narrow',convertCharsToStrings(selectedValues(i)),'.png'));
end
function [jsonX,jsonY]=drawBroad(x,i,ymin,ymax,Dist,distX,distY,resolution)
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
fig = figure('Position',[10 10 1000 500],...
    'visible','off');
subplot(1,3,1);
boxplot(DistancesX,'symbol',' ');
title("Broad Side captured in X-Direction");
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
subplot(1,3,2);
boxplot(DistancesY,'symbol',' ');
title("Broad Side captured in Y-Direction");
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
subplot(1,3,3);
plot(x,median(DistancesX),x,median(DistancesY),x,distX,'g-',x,distY);
ylim([ymin ymax])
xticks(1:3:29);
xticklabels([1:3:29]);
title("Mean of Both directions");
legend({'X-Direction','Y-Direction','X-User','Y-User'},'FontSize',12,'FontName','LM ROMAN 12','FontWeight','bold');
saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\Final\','Broad',convertCharsToStrings(selectedValues(i)),'.png'));
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