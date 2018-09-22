function score = CalculateScore(pointsFound,userPoints,pointRange)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Sort Array Rows by second column
pointsFound=sortrows(pointsFound,2);
userPoints = sortrows(userPoints,2);

if size(pointsFound,1)==0
    score=0;
else

Result = [];
for i=1:size(userPoints,1)
    for j=1:size(pointsFound,1)
        Result(i,j)=calculateDistance(pointsFound(j,:),userPoints(i,:));
    end
    Result(i,j+1)=min(Result(i,1:j));
end



score = sum(Result(:,j+1) <=pointRange);

end
    function distance = calculateDistance(xy1,xy2)
        %Based on Pythagorean theorem
        distance = sqrt((xy2(1)-xy1(1))^2+(xy2(2)-xy1(2))^2);
    end


end

