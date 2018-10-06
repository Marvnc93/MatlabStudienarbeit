function Point_extractionX(app,Settings,selectedValues,drawFigures,stepsForFigures,j,i,Side)
%function Point_extractionX()
%POINT_EXTRACTIONX Summary of this function goes here
%   Detailed explanation goes here


if Side =="Narrow"
    ImgC=app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,1};
    ImgA=app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,1};
    
    pointsFoundC = GetPoints(ImgC,Settings.XCathode,15);
    pointsFoundA = GetPoints(ImgA,Settings.XAnode,15);
    
    pointsCReal = [pointsFoundC(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,2}-300),pointsFoundC(:,2)];
    pointsAReal = [pointsFoundA(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,2}-150),pointsFoundA(:,2)];
    app.Distances.(selectedValues{i}).PointsX(j+1,1) = {sortrows(pointsCReal,2)};
    app.Distances.(selectedValues{i}).PointsX(j+1,2) = {sortrows(pointsAReal,2)};
    %% Loop for Images
    if drawFigures==true && mod(j,stepsForFigures)==0
        fig = figure('visible','off',...
            'Position',[500 300 500 700]);
        subplot(2,2,1)
        imshow(ImgC);
        hold on;
        plot(pointsFoundC(:,1),pointsFoundC(:,2),'gx');
        title('Cathode');
        subplot(2,2,2)
        imshow(ImgA);
        hold on;
        plot(pointsFoundA(:,1),pointsFoundA(:,2),'gx');
        title('Anode');
        subplot(2,2,[3 4]);
        A =imread(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,4});
        imshow(A);
        hold on;
        plot(pointsFoundC(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,2}-300),pointsFoundC(:,2),'gx');
        hold on;
        plot(pointsFoundA(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,2}-150),pointsFoundA(:,2),'gx');
        title('Full Picture');
        saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\PointsX\Narrow\',int2str(i),filesep,int2str(j),'.png'));
    end
end
if Side =="Broad"
    ImgC=app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,1};
    ImgA=app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI{j,1};
    
    pointsFoundC = GetPoints(ImgC,Settings.XCathode,15);
    pointsFoundA = GetPoints(ImgA,Settings.XAnode,15);
    if numel(pointsFoundC)~=0 && numel(pointsFoundC)~=0
    pointsCReal = [pointsFoundC(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,2}-300),pointsFoundC(:,2)];
    pointsAReal = [pointsFoundA(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI{j,2}-150),pointsFoundA(:,2)];
    app.Distances.(selectedValues{i}).PointsX(j+1,3) = {sortrows(pointsCReal,2)};
    app.Distances.(selectedValues{i}).PointsX(j+1,4) = {sortrows(pointsAReal,2)};
    %% Loop for Images
    if drawFigures==true && mod(j,stepsForFigures)==0
        fig = figure('visible','off',...
            'Position',[500 300 500 700]);
        subplot(2,2,1)
        imshow(ImgC);
        hold on;
        plot(pointsFoundC(:,1),pointsFoundC(:,2),'gx');
        title('Cathode');
        subplot(2,2,2)
        imshow(ImgA);
        hold on;
        plot(pointsFoundA(:,1),pointsFoundA(:,2),'gx');
        title('Anode');
        subplot(2,2,[3 4]);
        A =imread(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,4});
        imshow(A);
        hold on;
        plot(pointsFoundC(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,2}-300),pointsFoundC(:,2),'gx');
        hold on;
        plot(pointsFoundA(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI{j,2}-150),pointsFoundA(:,2),'gx');
        title('Full Picture');
        saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\PointsX\Broad\',int2str(i),filesep,int2str(j),'.png'));
    end
    else
    app.Distances.(selectedValues{i}).PointsX(j+1,3) = {0};
    app.Distances.(selectedValues{i}).PointsX(j+1,4) = {0};
    end
        
end

end