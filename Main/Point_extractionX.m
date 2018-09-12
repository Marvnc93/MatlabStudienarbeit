%function Point_extractionX(app)
function Point_extractionX()
%POINT_EXTRACTIONX Summary of this function goes here
%   Detailed explanation goes here

if exist('app','var') ==0
    app = load('D:\Studienarbeit\ProgrammFolder\apptest_ROIX.mat');
    app =app.app;
end
settings=load('D:\Studienarbeit\ProgrammFolder\settings.mat');
settings=settings.settings;

selectedValues=app.FolderSelection.InputFolders.Selected_Values;
stepsForFigures =10;
drawFigures = true;
  %!!!!!!!!!!!!! A
for i=1:length(selectedValues)
    for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI),1)
        ImgC=app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,1};
        ImgA=app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,1};

        pointsFoundC = GetPoints(ImgC,settings,14);
        pointsFoundA = GetPoints(ImgA,settings,15); 
        %% Loop for Images
        if drawFigures==true && mod(j,stepsForFigures)==0
            fig = figure('visible','off',...
                'Position',[500 300 500 700]);
            subplot(2,2,1)
            imshow(ImgC);
            hold on;
            plot(pointsFoundC.Location(:,1),pointsFoundC.Location(:,2),'gx');
            title('Cathode');
            subplot(2,2,2)
            imshow(ImgA);
            hold on;
            plot(pointsFoundA.Location(:,1),pointsFoundA.Location(:,2),'gx');
            title('Anode');
            subplot(2,2,[3 4]);
            A =imread(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,4});
            imshow(A);
            hold on;
            plot(pointsFoundC.Location(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,2}-99),pointsFoundC.Location(:,2),'gx');
            hold on;
            plot(pointsFoundA.Location(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,2}-99),pointsFoundA.Location(:,2),'gx');
            title('Full Picture');
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\PointsX\Narrow\',int2str(i),filesep,int2str(j),'.png'));
        end
    end
end
for i=1:length(selectedValues)
    for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI),1)
        ImgC=app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,1};
        ImgA=app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI{j,1};

        pointsFoundC = GetPoints(ImgC,settings,14);
        pointsFoundA = GetPoints(ImgA,settings,15); 
        %% Loop for Images
        if drawFigures==true && mod(j,stepsForFigures)==0
            fig = figure('visible','off',...
                'Position',[500 300 500 700]);
            subplot(2,2,1)
            imshow(ImgC);
            hold on;
            plot(pointsFoundC.Location(:,1),pointsFoundC.Location(:,2),'gx');
            title('Cathode');
            subplot(2,2,2)
            imshow(ImgA);
            hold on;
            plot(pointsFoundA.Location(:,1),pointsFoundA.Location(:,2),'gx');
            title('Anode');
            subplot(2,2,[3 4]);
            A =imread(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,4});
            imshow(A);
            hold on;
            plot(pointsFoundC.Location(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,2}-99),pointsFoundC.Location(:,2),'gx');
            hold on;
            plot(pointsFoundA.Location(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI{j,2}-99),pointsFoundA.Location(:,2),'gx');
            title('Full Picture');
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\PointsX\Broad\',int2str(i),filesep,int2str(j),'.png'));
        end
    end
end
    

end