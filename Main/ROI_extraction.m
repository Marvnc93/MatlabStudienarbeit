%function [] = ROI_extraction(app)
function[] = ROI_extraction()
%ROI_EXTRACTION Summary of this function goes here
%   Detailed explanation goes here
app = load('apptest.mat');
app =app.app;
%i=3;
test=[];
selectedValues=app.FolderSelection.InputFolders.Selected_Values;
pointsFoundN=int64([]);
pointsFoundB=int64([]);
pointsFoundY=int64([]);
imagesToKeepY =[];
tubeWidth = 4;
tresholdDivideY = 100;
createFigures =false;
imgCounter=0;
stepsForFigures=25;
% to iterate through struct
%app.ImageSelection.(selectedValues{1}).X_Narrow;

%----------------------------------------------------------------------------------------
%For Y
%j=1;
% Img=imread(app.ImageSelection.(selectedValues{1}).Y(j,:));
% Img =imrotate(Img,90);
% meanGrayX=mean(Img);
for i=1:numel(selectedValues)
    Y.(selectedValues{i}) =struct;
    Y.(selectedValues{i}).leftCathodeROI = {};
    Y.(selectedValues{i}).leftAnodeROI = {};
    Y.(selectedValues{i}).rightCathodeROI = {};
    Y.(selectedValues{i}).rightAnodeROI = {};
end
for i=1:numel(selectedValues)
    %for i=2:2
    dirPathY = strcat(app.FolderSelection.Output_Path,filesep,selectedValues{i},'\YROIFigures');
    mkdir  (dirPathY);
    
    for j=1:size((app.ImageSelection.(selectedValues{i}).Y),1)
        ImgY=imread(app.ImageSelection.(selectedValues{i}).Y(j,:));
        ImgY =imrotate(ImgY,90);
        meanGrayY = mean(ImgY);
        %Smoothing of the function with a moving average and the span of 50
        meanGrayYSmooth=transpose(smooth(meanGrayY,50));
        %Array that stores all the points that are outside of the tube
        pointsFoundY=[];
        for k=6:numel(meanGrayYSmooth)
            % A Tube around the Chart that trails by 5 entrys und a width
            % that is defined at the top
            % if a Value is out of the tupe it is added to the pointsFound Matrix
            if meanGrayYSmooth(k)>meanGrayYSmooth(k-5)+tubeWidth/2 || meanGrayYSmooth(k)<meanGrayYSmooth(k-5)-tubeWidth/2
                pointsFoundY = [pointsFoundY;k];
            end
            
        end
        %Calculate 4 centroids with the kmeans algorithm
        %The classes are added to the pointsFoundY matrix
        pointsFoundY = [pointsFoundY,kmeans(pointsFoundY,4)];
        centroids=[];
        %This loop forms the Xx2 matrix pointsFoundY Matrix to an Xx4
        %Matrix which is saved in centroids - 1 class per column
        %First row of centroids is kept empty
        for m=1:4
            k=2;
            for n=1:size(pointsFoundY,1)
                if pointsFoundY(n,2)==m
                    centroids(k,m) = pointsFoundY(n,1);
                    k = k+1;
                end
            end
        end
        %First row of centroids is filled with the mean of each column the
        %zeroes are excluded
        for o=1:4
            centroids(1,o)= int64(mean(nonzeros(centroids(:,o))));
        end
        
        rOIcentroids = sort(centroids(1,:));
        difference =[0,diff(rOIcentroids)];
        
        %Calculate the number of dived -> A division is 2 aside points from the
        %centroids with a distance <tresholdDivideY
        numberDivides = sum (difference>tresholdDivideY);
        useImage=0;
        if numberDivides == 3
            %imagesToKeepY =[imagesToKeepY;{app.ImageSelection.(selectedValues{i}).Y(j,:),1}];
            useImage=1;
        else
            %imagesToKeepY =[imagesToKeepY;{app.ImageSelection.(selectedValues{i}).Y(j,:),0}];
            useImage=0;
            %continue;
        end
        if rOIcentroids(3)-rOIcentroids(2)<250
            %imagesToKeepY =[imagesToKeepY;{app.ImageSelection.(selectedValues{i}).Y(j,:),0}];
            useImage=0;
            %continue;
        end
        
        %Sometimes the first centroid is <100 pixel away from the edge
        if rOIcentroids(1) <101
            Y.(selectedValues{i}).leftCathodeROI = [Y.(selectedValues{i}).leftCathodeROI;{ImgY(:,1:rOIcentroids(1)+99)},rOIcentroids(1),useImage];
        else
            Y.(selectedValues{i}).leftCathodeROI = [Y.(selectedValues{i}).leftCathodeROI;{ImgY(:,rOIcentroids(1)-100:rOIcentroids(1)+99)},rOIcentroids(1),useImage];
        end
        %Sometimes the second centroid is <100 pixel away from the edge
        if rOIcentroids(2)<101
            Y.(selectedValues{i}).leftAnodeROI = [Y.(selectedValues{i}).leftAnodeROI;{ImgY(:,1:rOIcentroids(2)+99)},rOIcentroids(2),useImage];
        else
            Y.(selectedValues{i}).leftAnodeROI = [Y.(selectedValues{i}).leftAnodeROI;{ImgY(:,rOIcentroids(2)-100:rOIcentroids(2)+99)},rOIcentroids(2),useImage];
        end
        Y.(selectedValues{i}).rightCathodeROI = [Y.(selectedValues{i}).rightCathodeROI;{ImgY(:,rOIcentroids(3)-100:rOIcentroids(3)+99)},rOIcentroids(3),useImage];
        Y.(selectedValues{i}).rightAnodeROI = [Y.(selectedValues{i}).rightAnodeROI;{ImgY(:,rOIcentroids(4)-100:rOIcentroids(4)+99)},rOIcentroids(4),useImage];
        
        %this counter keeps track of all the images run through - important
        %to pick the right picture from Y.x
        imgCounter = imgCounter+1;
        
        %Later to show figures
        if mod(j,stepsForFigures)==0 || j==1 && createFigures==true
            fig = figure('visible','off');
            subplot(3,4,[1,4])
            imshow(ImgY);
            title(strcat('X-Ray Image Used:',int2str(useImage)));
            subplot(3,4,[5,8])
            %Smooth GreyScale Plot
            plot(linspace(1,numel(meanGrayYSmooth),numel(meanGrayYSmooth)),meanGrayYSmooth);
            title('Mean Gray Values');
            axis([0 inf 0 110]);
            hold on;
            %Raw GreyScale Plot
            %plot(linspace(1,numel(meanGrayY),numel(meanGrayY)),meanGrayY,'k');
            %Centroids from the K-Means
            plot(centroids(1,:),meanGrayYSmooth(centroids(1,:)),'go');
            %All points detected
            %plot(pointsFoundY,meanGrayYSmooth(pointsFoundY),'x');
            hold off;
            subplot(3,4,9);
            imshow(Y.(selectedValues{i}).leftCathodeROI{j});
            subplot(3,4,10);
            imshow(Y.(selectedValues{i}).leftAnodeROI{j});
            subplot(3,4,11);
            imshow(Y.(selectedValues{i}).rightCathodeROI{j});
            subplot(3,4,12);
            imshow(Y.(selectedValues{i}).rightAnodeROI{j});
            saveas(fig,strcat(dirPathY,filesep,int2str(j),'.png'));
            %save(strcat(dirPathY,filesep,'ImagesToKeep.mat'),'imagesToKeepY');
        end
    end
end
% fig2 = figure('visible','on');
% plot(linspace(1,numel(meanGrayYSmooth),numel(meanGrayYSmooth)),meanGrayYSmooth);
%hold on;
%plot(linspace(1,numel(meanGrayY),numel(meanGrayY)),fit(meanGrayY,'poly2'),'g');
% x=transpose(linspace(1,numel(meanGrayY),numel(meanGrayY)));
%y=transpose(meanGrayY);
%y=meanGrayY;
%plot(x,smooth(y,50),'g');
i




%----------------------------------------------------------------------------------------

% %-----------------------------------------------------------------------------------------
% %For X_Narrow % X_Broad
% X_Narrow.cathodeROI ={};
% X_Narrow.anodeROI ={};
% X_Broad.cathodeROI ={};
% X_Broad.anodeROI ={};
%
% %Narrow
% for j=1:size((app.ImageSelection.(selectedValues{1}).X_Narrow),1)
%         ImgN=imread(app.ImageSelection.(selectedValues{1}).X_Narrow(j,:));
%         meanGrayX=mean(ImgN);
%     pointsFoundN=[];
%     for j=6:numel(meanGrayX)
%         %for k=1:20
%         %    lastGrayValues = [lastGrayValues, meanGrayX(j-k)];
%         %end
%         % A Tube around the Chart that trails by 5 entrys
%         % if a Value is out of the tupe it is added to the pointsFound Matrix
%         if meanGrayX(j)>meanGrayX(j-5)+tubeWidth/2 || meanGrayX(j)<meanGrayX(j-5)-tubeWidth/2
%             pointsFoundN = [pointsFoundN,j];
%         end
%     end
% % Check for the position of the biggest jump in the pointsFound Array
%     difference =[0];
%     for k=2:numel(pointsFoundN)
%         difference = [difference,abs(pointsFoundN(k)-pointsFoundN(k-1))];
%     end
%     [maxValue ,maxIndex] = max(difference);
%     cathodeROIPosition =  int64(mean(pointsFoundN(1:maxIndex-1)));
%     anodeROIPosition = int64(mean(pointsFoundN(maxIndex: end)));
%
%     X_Narrow.cathodeROI = [X_Narrow.cathodeROI,{ImgN(:,cathodeROIPosition-100:cathodeROIPosition+99)}];
%     X_Narrow.anodeROI = [X_Narrow.anodeROI,{ImgN(:,anodeROIPosition-100:anodeROIPosition+99)}];
%
% end
% %Broad
% for j=1:size((app.ImageSelection.(selectedValues{1}).X_Broad),1)
%     ImgB=imread(app.ImageSelection.(selectedValues{1}).X_Broad(j,:));
%     meanGrayX=mean(ImgB);
%     pointsFoundB=[];
%     for j=6:numel(meanGrayX)
%         if meanGrayX(j)>meanGrayX(j-5)+tubeWidth/2 || meanGrayX(j)<meanGrayX(j-5)-tubeWidth/2
%             pointsFoundB = [pointsFoundB,j];
%         end
%     end
% % Check for the position of the biggest jump in the pointsFound Array
%     difference =[0];
%     for k=2:numel(pointsFoundB)
%         difference = [difference,abs(pointsFoundB(k)-pointsFoundB(k-1))];
%     end
%     [maxValue ,maxIndex] = max(difference);
%     cathodeROIPosition =  int64(mean(pointsFoundB(1:maxIndex-1)));
%     anodeROIPosition = int64(mean(pointsFoundB(maxIndex: end)));
%
%     X_Broad.cathodeROI = [X_Broad.cathodeROI,{ImgB(:,cathodeROIPosition-100:cathodeROIPosition+99)}];
%     X_Broad.anodeROI = [X_Broad.anodeROI,{ImgB(:,anodeROIPosition-100:anodeROIPosition+99)}];
%
% end
%
% %----------------------------------------------------------------------------------------

%create Mat in Input folder

%Debug
% Narrow: Show the Image, Greyscale Plot and the 2 ROIs
%     figure
%     subplot(3,2,[1,2])
%     imshow(ImgN);
%     subplot(3,2,[3,4])
%     plot(linspace(1,1405,1405),meanGrayX);
%     hold on;
%     plot(pointsFoundN,meanGrayX(pointsFoundN),'x');
%     %plot(cathodeROIPosition,meanGrayX(cathodeROIPosition),'x');
%     hold on;
%     %plot(anodeROIPosition,meanGrayX(anodeROIPosition),'o');
%     subplot(3,2,5);
%     imshow(X_Narrow.cathodeROI{251});
%     subplot(3,2,6)
%     imshow(X_Narrow.anodeROI{251});
%Broad: Show the Image, Greyscale Plot and the 2 ROIs
%     figure
%     subplot(3,2,[1,2])
%     imshow(ImgB);
%     subplot(3,2,[3,4])
%     plot(linspace(1,1405,1405),meanGrayX);
%     hold on;
%     plot(pointsFoundB,meanGrayX(pointsFoundB),'x');
%     %plot(cathodeROIPosition,meanGrayX(cathodeROIPosition),'x');
%     hold on;
%     %plot(anodeROIPosition,meanGrayX(anodeROIPosition),'o');
%     subplot(3,2,5);
%     imshow(X_Broad.cathodeROI{end});
%     subplot(3,2,6)
%     imshow(X_Broad.anodeROI{end});

%     fields = fieldnames(app.ImageSelection.(selectedValues{1}));
%         for i=1:numel(fields)
%         app.ImageSelection.(selectedValues{1}).(fields{i});

end


