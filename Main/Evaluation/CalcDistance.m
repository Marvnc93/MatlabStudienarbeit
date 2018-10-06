function CalcDistance(app,selectedValues,angle,j,i,type,imagetype)
%CALCDISTANCE Summary of this function goes here
%   Detailed explanation goes here
if imagetype=="X"
    if type == "Narrow"
        %Load the values according to PointsX - only x values relevant
        pointsC = app.Distances.(selectedValues{i}).PointsX{j+1,1}(:,1);
        pointsA = app.Distances.(selectedValues{i}).PointsX{j+1,2}(:,1);
        app.Distances.(selectedValues{i}).DistancesX{j+1,1} = GetDistance(pointsC,pointsA);
        app.Distances.(selectedValues{i}).DistancesX{j+1,2} = app.Distances.(selectedValues{i}).DistancesX{j+1,1}*sin((90+angle)/180*pi);
        writePointsX(1,3);
        writePointsX(2,4);
    end
    if type == "Broad"
        %Load the values according to PointsX - only x values relevant
        if app.Distances.(selectedValues{i}).PointsX{j+1,3}~=0
            pointsC = app.Distances.(selectedValues{i}).PointsX{j+1,3}(:,1);
            pointsA = app.Distances.(selectedValues{i}).PointsX{j+1,4}(:,1);
            app.Distances.(selectedValues{i}).DistancesX{j+1,5} = GetDistance(pointsC,pointsA);
            app.Distances.(selectedValues{i}).DistancesX{j+1,6} = app.Distances.(selectedValues{i}).DistancesX{j+1,5}*cos((90+angle)/180*pi);
            writePointsX(5,7);
            writePointsX(6,8);
        end
    end
end

if imagetype=="Y"
    if type == "Left"
        if numel(app.Distances.(selectedValues{i}).PointsY{j+1,1})==30 && numel(app.Distances.(selectedValues{i}).PointsY{j+1,2})==30
        %Load the values according to PointsY - only x values relevant
        pointsC = app.Distances.(selectedValues{i}).PointsY{j+1,1}(:,1);
        pointsA = app.Distances.(selectedValues{i}).PointsY{j+1,2}(:,1);
        app.Distances.(selectedValues{i}).DistancesY{j+1,1} = GetDistance(pointsC,pointsA);
        app.Distances.(selectedValues{i}).DistancesY{j+1,2} = app.Distances.(selectedValues{i}).DistancesY{j+1,1}*sin((90+angle)/180*pi);
        writePointsY(1,3);
        writePointsY(2,4);
        end
    end
    if type == "Right"
        if app.Distances.(selectedValues{i}).PointsY{j+1,3}~=0
            if numel(app.Distances.(selectedValues{i}).PointsY{j+1,3})==30 && numel(app.Distances.(selectedValues{i}).PointsY{j+1,4})==30
            pointsC = app.Distances.(selectedValues{i}).PointsY{j+1,3}(:,1);
            pointsA = app.Distances.(selectedValues{i}).PointsY{j+1,4}(:,1);
            app.Distances.(selectedValues{i}).DistancesY{j+1,5} = GetDistance(pointsC,pointsA);
            app.Distances.(selectedValues{i}).DistancesY{j+1,6} = app.Distances.(selectedValues{i}).DistancesY{j+1,5}*cos((90+angle)/180*pi);
            writePointsY(5,7);
            writePointsY(6,8);
            end
        end
    end
end




    function distances = GetDistance(pointsCathode,pointsAnode)
        cc =1;
        ca =1;
        for m = 1:29
            distances(m,1)= abs(pointsCathode(cc)-pointsAnode(ca));
            if mod(m,2)==0
                ca = ca+1;
            else
                cc = cc+1;
            end
        end
    end
    function writePointsX(inputcolumn,outputcolumn)
        for n = 1:29
            app.Distances.(selectedValues{i}).DistancesX{31,outputcolumn}=[];
            app.Distances.(selectedValues{i}).DistancesX{n+1,outputcolumn}=[app.Distances.(selectedValues{i}).DistancesX{n+1,outputcolumn};app.Distances.(selectedValues{i}).DistancesX{j+1,inputcolumn}(n)];
        end
    end
    function writePointsY(inputcolumn,outputcolumn)
        for n = 1:29
            app.Distances.(selectedValues{i}).DistancesY{31,outputcolumn}=[];
            app.Distances.(selectedValues{i}).DistancesY{n+1,outputcolumn}=[app.Distances.(selectedValues{i}).DistancesY{n+1,outputcolumn};app.Distances.(selectedValues{i}).DistancesY{j+1,inputcolumn}(n)];
        end
    end
end

