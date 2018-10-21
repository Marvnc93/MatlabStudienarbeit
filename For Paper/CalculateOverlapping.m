%Dist = app.Distances;

Dist = load("dist.mat");
load('userdist.mat');
Dist=Dist.dist;
selectedValues = fieldnames(Dist);
x = 1:1:29;
%pixel to mm
resolution = 25/1000;
for i=1:length(selectedValues)
    rate=getOverlapping(x,i,Dist,resolution);
   % [jsonBX,jsonBY]=(x,i,0,350*resolution,Dist,userdist.X.(selectedValues{i}).broad.*resolution,userdist.Y.(selectedValues{i}).left .*resolution,resolution);
   

end

function rate=getOverlapping(x,i,Dist,resolution)
selectedValues = fieldnames(Dist);
% DistancesX = Dist.(selectedValues{i}).ResultsX{2,1}(:,1);
% DistancesY = Dist.(selectedValues{i}).ResultsY{2,2}(:,1);
DistancesXn=[];
DistancesYn=[];
DistancesXb=[];
DistancesYb=[];
for j=2:30
    DistancesXn = [DistancesXn,Dist.(selectedValues{i}).DistancesX{j,4}];
end
for j=2:30
    DistancesYn = [DistancesYn,Dist.(selectedValues{i}).DistancesY{j,8}];
end
for j=2:30
    DistancesXb = [DistancesXb,Dist.(selectedValues{i}).DistancesX{j,8}];
end
for j=2:30
    DistancesYb = [DistancesYb,Dist.(selectedValues{i}).DistancesY{j,4}];
end
medianXn = nanmedian(DistancesXn).*resolution;
medianYn = nanmedian(DistancesYn).*resolution;
medianXb = nanmedian(DistancesXb).*resolution;
medianYb = nanmedian(DistancesYb).*resolution;

rate=[];
%from geometrical data
for j=1:29
    
AnodeRectY = [0,0 110,150];
CathodeRectY = [medianXb(j), medianXn(j),105,145];
CathodeArea = 105*145;
overlappingArea= rectint(AnodeRectY,CathodeRectY);
overlappingRate = overlappingArea/CathodeArea;
rate = [rate;overlappingRate];
end

end
