function score = CalculateScore(pointsFound,userPoints,pointRange)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Sort Array Rows by second column
if numel(pointsFound)==0
    score=0;
else
    pointsFound=sortrows(pointsFound,2);
    userPoints = sortrows(userPoints,2);
    
    score=0;
    Result = [];
    for i=1:size(userPoints,1)
        for j=1:size(pointsFound,1)
            Result(i,j)=calculateDistance(pointsFound(j,:),userPoints(i,:));
        end
    end
    for k=1:j
        [M,I] = min(Result(1:j,k));
        Result(i+1,k) = M;
        if M<=pointRange
            score=score+1;
            for m=1:j
                Result(I,m)=999;
            end
        end
    end
end


%score = sum(Result(i+1,:) <=pointRange);


    function distance = calculateDistance(xy1,xy2)
        %Based on Pythagorean theorem
        distance = sqrt((xy2(1)-xy1(1))^2+(xy2(2)-xy1(2))^2);
    end


end

