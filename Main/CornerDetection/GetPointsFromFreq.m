function pointsOut = GetPointsFromFreq(Img,pointsIn,range,loopIter)
%GETPOINTSFROMFREQ Summary of this function goes here
%   Detailed explanation goes here

pointsIn = pointsIn.selectStrongest(15).Location;

meanGrey = mean(Img,2);
%Img = imadjust(Img,[mean(meanGrey)/255 1],[0 1]);
x = transpose(1:length(meanGrey));
%Factor just for optics
y = meanGrey*2;
[pks,ind] = findpeaks(y,'MinPeakDistance',10);
[M,I] = maxk(pks,15);
%%No peaks detected -> algorithm cannot work
if numel(I)<2 || numel(pointsIn)<4 
    pointsOut=pointsIn;
else
    %% Interpolation
    pointsIn = removePoints(pointsIn,range);
    if numel(pointsIn)<4 || numel(pointsIn)==30
        pointsOut=pointsIn;
    else
        pointsInx = pointsIn(:,1);
        pointsIny = pointsIn(:,2);
        yInterpol = linspace(min(pointsIny),max(pointsIny),800);
        xInterpol = interp1(pointsIny, pointsInx,yInterpol,'pchip');
        
        missingPointsValY = YCoordinatesForMissingPoints(pointsIny,x(ind(I)),min(pointsIny),max(pointsIny));
        missingPointsValX =[];
        if numel(missingPointsValY)>0
            for i=1:numel(missingPointsValY)
                [c,index] = min(abs(missingPointsValY(i)-yInterpol));
                missingPointsValX = [missingPointsValX;xInterpol(index)];
            end
        end
        pointsOut=[pointsIn;...
            missingPointsValX,missingPointsValY];
%         %Figures
%         fig = figure('visible','off',...
%             'Position',[500 300 500 700]);
%         imshow(Img);
%         hold on;
%         plot(y,x,'b-','LineWidth',2);
%         hold on;
%         plot(M,x(ind(I)),'rx','MarkerSize',12,'LineWidth',2);
%         hold on;
%         plot(xInterpol,yInterpol,'b-','LineWidth',2);
%                 hold on;
%         plot(pointsInx,pointsIny,'g+','MarkerSize',12,'LineWidth',2);
%         if numel(missingPointsValY)>0
%             hold on;
%             plot([0 349],[missingPointsValY missingPointsValY],'c-','LineWidth',2);
%             hold on;
%             plot(missingPointsValX,missingPointsValY,'y+','MarkerSize',12,'LineWidth',2);
%         end
%         saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\IAandCD\ResultFreq\',int2str(loopIter),'.png'));
%         
%         
        
        if numel(pointsOut)~=30
            "Error in GetPointsFromFreq (too few points)"
        end
    end
end

% %+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,2}-99)

%% Function to get ycoord of points that are missing
    function ycoord = YCoordinatesForMissingPoints(detectedPoints,freqpoints,mini,maxi)
        freqpoints = sort(freqpoints);
        distances=[];
        for h=1:size(detectedPoints,1)
            distances(:,h)=abs(detectedPoints(h)-freqpoints);
        end
        minValue = transpose(mink(distances(1:end,:),2,2));
        minValue(3,:) = sum(minValue,1);
        for j=1:size(minValue,2)
            quotient=minValue(1,j)/minValue(2,j);
            if quotient >1
                quotient = 1/quotient
            end
            minValue(4,j) = quotient;
            minValue(5,j) = minValue(3,j)*quotient;
        end
        %output=[];
        %Search for points that are between the first and last point of the
        %detected points
        maxValue=0;
        missingPoints = 15-size(detectedPoints,1);
        for o = 1:missingPoints
            [~,maxInd] = maxk(minValue(5,:),missingPoints);
            maxValue = freqpoints(maxInd);
        end
        ycoord = maxValue;
        
        %         maxValue = 0;
        %         counter = 1;
        %         while maxValue > maxi || maxValue <mini
        %             [~,maxInd] = maxk(minValue(5,:),counter);
        %             maxValue = freqpoints(maxInd(counter));
        %             counter=counter+1;
        %             if counter>numel(maxInd)
        %                 break;
        %             end
        %         end
        %         minValue(5,maxInd)=999;
        %         output=[output,maxValue];
        %     end
        %ycoord =output;
    end
%Function to remove all points that are to close togethe
%Like get all points, but fewer amount of points can be kept
    function out = removePoints(points,min)
        points=sortrows(points,2);
        distances=tril(squareform(pdist(points)),-1);
        %We need one point in top triangle
        distances (end-1,end)= distances(end,end-1);
        %points(i-1,4) = points(i-1,4);
        out=points;
        out =out(~any(distances<min & distances ~=0,1),:);
    end
end

