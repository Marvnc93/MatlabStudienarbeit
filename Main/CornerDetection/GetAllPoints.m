function out = GetAllPoints(inputPoints,numPoints,minDistance)
%GETADDITIONALPOINTS Summary of this function goes here
%   Detailed explanation goes here

pointsFound = inputPoints.selectStrongest(40);
pointsFound = [pointsFound.Location pointsFound.Metric];
pointsFound=sortrows(pointsFound,2);
distances=[];
for i=2:length(pointsFound)
   pointsFound(i-1,4) = calculateDistance(pointsFound(i,:),pointsFound(i-1,:));
end
pointsFound(i-1,4) = pointsFound(i-1,4);
out=pointsFound;
out =out(any(pointsFound(:,4)>minDistance,2),:);
[B,I] =maxk(out(:,3),numPoints,1);
out = out(I,:);
    function distance = calculateDistance(xy1,xy2)
        %Based on Pythagorean theorem
        distance = sqrt((xy2(1)-xy1(1))^2+(xy2(2)-xy1(2))^2);
    end
end

