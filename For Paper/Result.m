%Dist = app.Distances;
Dist = load("dist.mat");
Dist=Dist.dist;
selectedValues = fieldnames(Dist);

i=1;
x = 1:1:29;

%% For Box
% Distances=[];
% for j=2:30
% Distances = [Distances,Dist.(selectedValues{i}).DistancesY{j,3}];
% end
% fig = figure;
% boxplot(Distances,'symbol',' ');


%% For errorbar
Results = [Dist.(selectedValues{i}).ResultsX,Dist.(selectedValues{i}).ResultsY];
%    {["Narrow" ]}    {["Broad"  ]}    {["Left"   ]}    {["Right"  ]}
%    {29×3 single}    {29×3 single}    {29×3 single}    {29×3 single}
% Narrow <-> Right Broad <->Left

% Narrow Cell Side
[nXdist,nXmin,nXmax] = normDistAndErr(Results{2,1}(:,1),Results{2,1}(:,2),Results{2,1}(:,3));
[nYdist,nYmin,nYmax] = normDistAndErr(Results{2,4}(:,1),Results{2,4}(:,2),Results{2,4}(:,3));
% Broad Cell Side
[bXdist,bXmin,bXmax] = normDistAndErr(Results{2,2}(:,1),Results{2,2}(:,2),Results{2,2}(:,3));
[bYdist,bYmin,bYmax] = normDistAndErr(Results{2,3}(:,1),Results{2,3}(:,2),Results{2,3}(:,3));

fig = figure;
subplot(1,2,1);
errorbar(x,nXdist,nXmin,nXmax);
hold on;
plot(x,nYdist);
subplot(1,2,2);
errorbar(x,bXdist,bXmin,bXmax);
hold on;
plot(x,bYdist);



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