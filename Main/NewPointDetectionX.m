function   NewPointDetectionX()
%NEWPOINTDETECTION Summary of this function goes here
%   Detailed explanation goes here

if exist('app','var') ==0
    app = load('D:\Studienarbeit\ProgrammFolder\apptest_ROIX.mat');
    app =app.app;
end

selectedValues=app.FolderSelection.InputFolders.Selected_Values;
stepsForFigures =10;
drawFigures = true;
% pointsFound = struct;

for i=1:length(selectedValues)
    for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI),1)
        ImgC=app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,1};
%         ImgA=app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,1};
        
        %% Cathode
        meanGreyAdjC = mean(mean(ImgC,2))*2;
        ImgC = imadjust(ImgC,[meanGreyAdjC/255,1],[0 1]);
        meanGreyC=mean(ImgC,2);
        xC = transpose(1:length(meanGreyC));
        yC = meanGreyC*1.5;
        [pksC,locsC] = findpeaks(yC,'MinPeakDistance',10);
        [MC,IC] = maxk(pksC,14);
%         %% Anode
%         meanGreyAdjA = mean(mean(ImgA,2));
%         ImgA = imadjust(ImgA,[meanGreyAdjA/255,1],[0 1]);
%         meanGreyA=mean(ImgA,2);
%         xA = transpose(1:length(meanGreyA));
%         yA = meanGreyA*1.5;
%         [pksA,locsA] = findpeaks(yA,'MinPeakDistance',8);
%         [MA,IA] = maxk(pksA,15);

        %app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,5} = pointsFoundC.Location;
        %app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,5} = pointsFoundA.Location;
        %% Loop for Images
        if drawFigures==true && mod(j,stepsForFigures)==0
            fig = figure('visible','off',...
                'Position',[500 300 500 700]);
%             subplot(1,2,1)
            imshow(ImgC);
            hold on;
            plot(yC,xC,MC,xC(locsC(IC)),'gx');
            title('Cathode');
%             subplot(1,2,2)
%             imshow(ImgA);
%             hold on;
%             plot(yA,xA,MA,xA(locsA(IA)),'gx');
%             title('Anode');
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\GreyscalePointsX\Narrow\',int2str(i),filesep,int2str(j),'.png'));
        end
    end
end
for i=1:length(selectedValues)
    for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI),1)
        ImgC=app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,1};
%         ImgA=app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI{j,1};
        
        %% Cathode
        meanGreyAdjC = mean(mean(ImgC,2))*2;
        ImgC = imadjust(ImgC,[meanGreyAdjC/255,1],[0 1]);
        meanGreyC=mean(ImgC,2);
        xC = transpose(1:length(meanGreyC));
        yC = meanGreyC*1.5;
        [pksC,locsC] = findpeaks(yC,'MinPeakDistance',10);
        [MC,IC] = maxk(pksC,14);
%         %% Anode
%         meanGreyAdjA = mean(mean(ImgA,2))*1.2;
%         ImgA = imadjust(ImgA,[meanGreyAdjA/255,1],[0 1]);
%         meanGreyA=mean(ImgA,2);
%         xA = transpose(1:length(meanGreyA));
%         yA = meanGreyA*1.5;
%         [pksA,locsA] = findpeaks(yA,'MinPeakDistance',8);
%         [MA,IA] = maxk(pksA,15);

        %app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,5} = pointsFoundC.Location;
        %app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,5} = pointsFoundA.Location;
        %% Loop for Images
        if drawFigures==true && mod(j,stepsForFigures)==0
            fig = figure('visible','off',...
                'Position',[500 300 500 700]);
%             subplot(1,2,1)
            imshow(ImgC);
            hold on;
            plot(yC,xC,MC,xC(locsC(IC)),'gx');
            title('Cathode');
%             subplot(1,2,2)
%             imshow(ImgA);
%             hold on;
%             plot(yA,xA,MA,xA(locsA(IA)),'gx');
%             title('Anode');
             saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\GreyscalePointsX\Broad\',int2str(i),filesep,int2str(j),'.png'));
        end
    end
end
%meanGrey = mean(Img((size(Img,2)/2-50):(size(Img,2)/2+50)));





end
