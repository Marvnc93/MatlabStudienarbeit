function Point_extractionY(app,Settings,selectedValues,drawFigures,stepsForFigures,j,i,Side)
%function Point_extractionX()
%POINT_EXTRACTIONX Summary of this function goes here
%   Detailed explanation goes here


if Side =="Left"
    ImgC=app.ImageSelection.(selectedValues{i}).Y_ROI.leftCathodeROI{j,1};
    ImgA=app.ImageSelection.(selectedValues{i}).Y_ROI.leftAnodeROI{j,1};
    if app.ImageSelection.(selectedValues{i}).Y_ROI.leftCathodeROI{j,3}==1 && app.ImageSelection.(selectedValues{i}).Y_ROI.leftAnodeROI{j,3}==1
        pointsFoundC = GetPoints(ImgC,Settings.YCathode,15);
        pointsFoundA = GetPoints(ImgA,Settings.YAnode,15);  
        pointsCReal = [pointsFoundC(:,1)+single(app.ImageSelection.(selectedValues{i}).Y_ROI.leftCathodeROI{j,2}),pointsFoundC(:,2)];
        pointsAReal = [pointsFoundA(:,1)+single(app.ImageSelection.(selectedValues{i}).Y_ROI.leftAnodeROI{j,2}),pointsFoundA(:,2)];
        app.Distances.(selectedValues{i}).PointsY(j+1,1) = {sortrows(pointsCReal,2)};
        app.Distances.(selectedValues{i}).PointsY(j+1,2) = {sortrows(pointsAReal,2)};
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
            A =imread(app.ImageSelection.(selectedValues{i}).Y_ROI.leftCathodeROI{j,4});
            A= imrotate(A,90);
            imshow(A);
            hold on;
            plot(pointsCReal(:,1),pointsCReal(:,2),'gx');
            hold on;
            plot(pointsAReal(:,1),pointsAReal(:,2),'gx');
            title('Full Picture');
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\PointsY\Left\',int2str(i),filesep,int2str(j),'.png'));
        end
    else
        app.Distances.(selectedValues{i}).PointsY(j+1,1) = {''};
        app.Distances.(selectedValues{i}).PointsY(j+1,2) = {''};
    end
end
if Side =="Right"
    ImgC=app.ImageSelection.(selectedValues{i}).Y_ROI.rightCathodeROI{j,1};
    ImgA=app.ImageSelection.(selectedValues{i}).Y_ROI.rightAnodeROI{j,1};
    if app.ImageSelection.(selectedValues{i}).Y_ROI.rightCathodeROI{j,3}==1 && app.ImageSelection.(selectedValues{i}).Y_ROI.rightAnodeROI{j,3}==1
        pointsFoundC = GetPoints(ImgC,Settings.YCathode,15);
        pointsFoundA = GetPoints(ImgA,Settings.YAnode,15);  
        pointsCReal = [pointsFoundC(:,1)+single(app.ImageSelection.(selectedValues{i}).Y_ROI.rightCathodeROI{j,2}),pointsFoundC(:,2)];
        pointsAReal = [pointsFoundA(:,1)+single(app.ImageSelection.(selectedValues{i}).Y_ROI.rightAnodeROI{j,2}),pointsFoundA(:,2)];
        app.Distances.(selectedValues{i}).PointsY(j+1,3) = {sortrows(pointsCReal,2)};
        app.Distances.(selectedValues{i}).PointsY(j+1,4) = {sortrows(pointsAReal,2)};
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
            A =imread(app.ImageSelection.(selectedValues{i}).Y_ROI.rightCathodeROI{j,4});
            A= imrotate(A,90);
            imshow(A);
            hold on;
            plot(pointsCReal(:,1),pointsCReal(:,2),'gx');
            hold on;
            plot(pointsAReal(:,1),pointsAReal(:,2),'gx');
            title('Full Picture');
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\PointsY\Right\',int2str(i),filesep,int2str(j),'.png'));
        end
    else
        app.Distances.(selectedValues{i}).PointsY(j+1,1) = {''};
        app.Distances.(selectedValues{i}).PointsY(j+1,2) = {''};
    end
end
end