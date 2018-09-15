function CalcDistance(app,selectedValues,angle,j,i,type)
%CALCDISTANCE Summary of this function goes here
%   Detailed explanation goes here
if type == "Narrow"
    %Load the values according to PointsX - only x values relevant
    pointsC = app.Distances.(selectedValues{i}).PointsX{j+1,1}(:,1);
    pointsA = app.Distances.(selectedValues{i}).PointsX{j+1,2}(:,1);
    app.Distances.(selectedValues{i}).DistancesX{j+1,1} = GetDistance(pointsC,pointsA);
    app.Distances.(selectedValues{i}).DistancesX{j+1,2} = app.Distances.(selectedValues{i}).DistancesX{j+1,1}*sin((90+angle)/180*pi);
end
if type == "Broad"
    %Load the values according to PointsX - only x values relevant
    pointsC = app.Distances.(selectedValues{i}).PointsX{j+1,3}(:,1);
    pointsA = app.Distances.(selectedValues{i}).PointsX{j+1,4}(:,1);
    app.Distances.(selectedValues{i}).DistancesX{j+1,3} = GetDistance(pointsC,pointsA);
    app.Distances.(selectedValues{i}).DistancesX{j+1,4} = app.Distances.(selectedValues{i}).DistancesX{j+1,3}*cos((90+angle)/180*pi);
end
    function distances = GetDistance(pointsCathode,pointsAnode)
        cc =1;
        ca =1;
        for m = 1:28
            distances(m,1)= abs(pointsCathode(cc)-pointsAnode(ca));
            if mod(m,2)==0
                cc = cc+1;
            else
                ca = ca+1;
            end
        end
    end
end

