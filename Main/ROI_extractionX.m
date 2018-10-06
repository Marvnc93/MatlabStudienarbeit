 function  ROI_extractionX(app)
%function[] = ROI_extractionX()


selectedValues=app.FolderSelection.InputFolders.Selected_Values;
pointsFoundN=int64([]);
pointsFoundB=int64([]);
tubeWidth = 8;
createFigures =false;
stepsForFigures=10;
smoothSpan = 50;
%-----------------------------------------------------------------------------------------
%For X_Narrow % X_Broad
%% Struct Initiation
for i=1:numel(selectedValues)
    X.(selectedValues{i}) =struct;
    X.(selectedValues{i}).narrowCathodeROI = {};
    X.(selectedValues{i}).narrowAnodeROI = {};
    X.(selectedValues{i}).broadCathodeROI = {};
    X.(selectedValues{i}).broadAnodeROI = {};
end
%% Iterate throught the selected Input folders

for i=1:numel(selectedValues)
    %% Folder Creation
    dirPathX = strcat(app.FolderSelection.Output_Path,filesep,selectedValues{i},'\XROIFigures');
    dirPathN = strcat(dirPathX,'\Narrow');
    dirPathB = strcat(dirPathX,'\Broad');
    if createFigures==true
        if exist(dirPathX)==0
            mkdir  (dirPathX);
        else
            rmdir(dirPathX,'s');
            mkdir  (dirPathX);
        end
        if exist(dirPathN)==0
            mkdir  (dirPathN);
        else
            rmdir(dirPathN,'s');
            mkdir  (dirPathN);
        end
        if exist(dirPathB)==0
            mkdir  (dirPathB);
        else
            rmdir(dirPathB,'s');
            mkdir  (dirPathB);
        end
    end
    %___________________________________________________________________________________________________
    %% Narrow Side
    for j=1:size((app.ImageSelection.(selectedValues{i}).X_Narrow),1)
        pathN=app.ImageSelection.(selectedValues{i}).X_Narrow(j,:);
        ImgN=imread(pathN);
        meanGrayX=mean(ImgN);
        meanGrayXSmooth=transpose(smooth(meanGrayX,smoothSpan));
        pointsFoundN=[];
        for k=6:numel(meanGrayX)
            if meanGrayX(k)>meanGrayX(k-5)+tubeWidth/2 || meanGrayX(k)<meanGrayX(k-5)-tubeWidth/2
                pointsFoundN = [pointsFoundN,k];
            end
        end
        % Check for the position of the biggest jump in the pointsFound Array
        %         for k=2:numel(pointsFoundN)
        %             difference = [difference,abs(pointsFoundN(k)-pointsFoundN(k-1))];
        %         end
        difference=diff(pointsFoundN);
        [maxValue ,maxIndex] = max(difference);
        cathodeROIPosition =  int64(mean(pointsFoundN(1:maxIndex-1)));
        anodeROIPosition = int64(mean(pointsFoundN(maxIndex: end)));
        if cathodeROIPosition <301
            cathodeROIPosition = 301;
        end
        %The 1 is added to signalize that the ROI are legitamate
        X.(selectedValues{i}).narrowCathodeROI = [X.(selectedValues{i}).narrowCathodeROI;{ImgN(:,cathodeROIPosition-300:anodeROIPosition-150)},cathodeROIPosition,1,pathN];
        X.(selectedValues{i}).narrowAnodeROI = [X.(selectedValues{i}).narrowAnodeROI;{ImgN(:,anodeROIPosition-150:anodeROIPosition+100)},anodeROIPosition,1,pathN];
        if mod(j,stepsForFigures)==0 && createFigures==true || j==1 && createFigures==true
            fig = figure('visible','off',...
                'position',[200 200 400 600]);

            % imshow(crop);
            % ylabel("Original",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold');
            subplot(3,2,[1,2])
            imshow(ImgN);
            title('X-Ray Image Narrow Side');
            subplot(3,2,[3,4])
            %Smooth GreyScale Plot
            plot(linspace(1,numel(meanGrayXSmooth),numel(meanGrayXSmooth)),meanGrayXSmooth,'k');
            title('Mean Gray Values');
            axis([0 inf 0 110]);
            hold on;
            %Raw GreyScale Plot
            %plot(linspace(1,numel(meanGrayY),numel(meanGrayY)),meanGrayY,'k');
            %Centroids from the K-Means
            %plot(centroids(1,:),meanGrayXSmooth(centroids(1,:)),'go');
            %All points detected
            plot(pointsFoundN,meanGrayXSmooth(pointsFoundN),'g+');
            hold off;
            subplot(3,2,5);
            imshow(X.(selectedValues{i}).narrowCathodeROI{j,1});
            subplot(3,2,6);
            imshow(X.(selectedValues{i}).narrowAnodeROI{j,1});

            saveas(fig,strcat(dirPathX,filesep,'Narrow\',int2str(j),'.png'));
            %save(strcat(dirPathY,filesep,'ImagesToKeep.mat'),'imagesToKeepY');
        end
    end
    %___________________________________________________________________________________________________
    %%  Broad
    
    for j=1:size((app.ImageSelection.(selectedValues{i}).X_Broad),1)
        pathB=app.ImageSelection.(selectedValues{i}).X_Broad(j,:);
        ImgB=imread(pathB);
        meanGrayX=mean(ImgB);
        meanGrayXSmooth=transpose(smooth(meanGrayX,smoothSpan));
        pointsFoundB=[];
        for k=6:numel(meanGrayX)
            if meanGrayX(k)>meanGrayX(k-5)+tubeWidth/2 || meanGrayX(k)<meanGrayX(k-5)-tubeWidth/2
                pointsFoundB = [pointsFoundB,k];
            end
        end
        % Check for the position of the biggest jump in the pointsFound Array
        
        %         for k=2:numel(pointsFoundB)
        %             difference = [difference,abs(pointsFoundB(k)-pointsFoundB(k-1))];
        %         end
        difference=diff(pointsFoundB);
        [maxValue ,maxIndex] = max(difference);
        cathodeROIPosition =  int64(mean(pointsFoundB(1:maxIndex-1)));
        anodeROIPosition = int64(mean(pointsFoundB(maxIndex: end)));
        if cathodeROIPosition <301
            cathodeROIPosition = 301;
        end
        X.(selectedValues{i}).broadCathodeROI = [X.(selectedValues{i}).broadCathodeROI;{ImgB(:,cathodeROIPosition-300:anodeROIPosition-150)},cathodeROIPosition,1,pathB];
        X.(selectedValues{i}).broadAnodeROI = [X.(selectedValues{i}).broadAnodeROI;{ImgB(:,anodeROIPosition-150:anodeROIPosition+100)},anodeROIPosition,1,pathB];
        %___________________________________________________________________________________________________
        %% Plot
        if mod(j,stepsForFigures)==0 && createFigures==true || j==1 && createFigures==true
            fig = figure('visible','off',...
                'position',[200 200 400 600]);
            subplot(3,2,[1,2])
            imshow(ImgB);
            title('X-Ray Image Broad Side');
            subplot(3,2,[3,4])
            %Smooth GreyScale Plot
            plot(linspace(1,numel(meanGrayXSmooth),numel(meanGrayXSmooth)),meanGrayXSmooth,'k');
            title('Mean Gray Values');
            axis([0 inf 0 110]);
            hold on;
            %Raw GreyScale Plot
            %plot(linspace(1,numel(meanGrayY),numel(meanGrayY)),meanGrayY,'k');
            %Centroids from the K-Means
            %plot(centroids(1,:),meanGrayXSmooth(centroids(1,:)),'go');
            %All points detected
            plot(pointsFoundB,meanGrayXSmooth(pointsFoundB),'g+');
            hold off;
            subplot(3,2,5);
            imshow(X.(selectedValues{i}).broadCathodeROI{j,1});
            subplot(3,2,6);
            imshow(X.(selectedValues{i}).broadAnodeROI{j,1});
            saveas(fig,strcat(dirPathX,filesep,'Broad\',int2str(j),'.png'));
            %save(strcat(dirPathY,filesep,'ImagesToKeep.mat'),'imagesToKeepY');
        end
        
    end
    app.ImageSelection.(selectedValues{i}).X_ROI = X.(selectedValues{i});
    
end
close all;
end
%----------------------------------------------------------------------------------------

