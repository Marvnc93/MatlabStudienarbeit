%function [] = ROI_extraction(app)
function[] = ROI_extraction()
%ROI_EXTRACTION Summary of this function goes here
%   Detailed explanation goes here
app = load('apptest.mat');
app =app.app;
%i=3;
selectedValues=app.FolderSelection.InputFolders.Selected_Values;
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


%% Initialize the Structs
for i=1:numel(selectedValues)
    Y.(selectedValues{i}) =struct;
    Y.(selectedValues{i}).leftCathodeROI = {};
    Y.(selectedValues{i}).leftAnodeROI = {};
    Y.(selectedValues{i}).rightCathodeROI = {};
    Y.(selectedValues{i}).rightAnodeROI = {};
end
%% Loop over the selected Input Folders and create the Output Folders
for i=1:numel(selectedValues)
    %for i=2:2
    dirPathY = strcat(app.FolderSelection.Output_Path,filesep,selectedValues{i},'\YROIFigures');
    if createFigures==true
        if exist(dirPathY)==0
            mkdir  (dirPathY);
        else
            rmdir(dirPathY,'s');
            mkdir  (dirPathY);
        end
    end
    %% Loop over all images of a single Input Folder
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
            rOIcentroids(1)=100;
        end
        Y.(selectedValues{i}).leftCathodeROI = [Y.(selectedValues{i}).leftCathodeROI;{ImgY(:,rOIcentroids(1)-99:rOIcentroids(1)+100)},rOIcentroids(1),useImage];
        %Sometimes the second centroid is <100 pixel away from the edge
        if rOIcentroids(2) <101
            rOIcentroids(2)=100;
        end
        Y.(selectedValues{i}).leftAnodeROI = [Y.(selectedValues{i}).leftAnodeROI;{ImgY(:,rOIcentroids(2)-99:rOIcentroids(2)+100)},rOIcentroids(2),useImage];
        Y.(selectedValues{i}).rightCathodeROI = [Y.(selectedValues{i}).rightCathodeROI;{ImgY(:,rOIcentroids(3)-99:rOIcentroids(3)+100)},rOIcentroids(3),useImage];
        Y.(selectedValues{i}).rightAnodeROI = [Y.(selectedValues{i}).rightAnodeROI;{ImgY(:,rOIcentroids(4)-99:rOIcentroids(4)+100)},rOIcentroids(4),useImage];
        
        %this counter keeps track of all the images run through - important
        %to pick the right picture from Y.x
        imgCounter = imgCounter+1;
        %% Create the figures
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
    app.ImageSelection.(selectedValues{i}).Y_ROI = struct;
    app.ImageSelection.(selectedValues{i}).Y_ROI=Y.(selectedValues{i});
end

i;
end




