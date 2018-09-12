%function Point_extractionX(app)
function Point_extractionX()
%POINT_EXTRACTIONX Summary of this function goes here
%   Detailed explanation goes here

if exist('app','var') ==0
    app = load('D:\Studienarbeit\ProgrammFolder\apptest_ROIY.mat');
    app =app.app;
end
settings=load('D:\Studienarbeit\ProgrammFolder\settings.mat');
settings=settings.settings;

selectedValues=app.FolderSelection.InputFolders.Selected_Values;
stepsForFigures =10;
drawFigures = true;
  %!!!!!!!!!!!!! A
for i=1:length(selectedValues)
    for j=1:size((app.ImageSelection.(selectedValues{i}).Y_ROI.leftCathodeROI),1)
        ImgLC=app.ImageSelection.(selectedValues{i}).Y_ROI.leftCathodeROI{j,1};
        ImgLA=app.ImageSelection.(selectedValues{i}).Y_ROI.leftAnodeROI{j,1};
        ImgRC =app.ImageSelection.(selectedValues{i}).Y_ROI.rightCathodeROI{j,1};
        ImgRA =app.ImageSelection.(selectedValues{i}).Y_ROI.rightAnodeROI{j,1};

        pointsFoundLC = GetPoints(ImgLC,settings,14);
        pointsFoundLA = GetPoints(ImgLA,settings,15);
        pointsFoundRC = GetPoints(ImgRC,settings,14);
        pointsFoundRA = GetPoints(ImgRA,settings,15); 
        %% Loop for Images
        if drawFigures==true && mod(j,stepsForFigures)==0
            fig = figure('visible','off',...
                'Position',[500 300 500 900]);
            subplot(2,4,1)
            imshow(ImgLA);
            hold on;
            plot(pointsFoundLA.Location(:,1),pointsFoundLA.Location(:,2),'gx');
            title('left Anode');
            subplot(2,4,2)
            imshow(ImgLC);
            hold on;
            plot(pointsFoundLC.Location(:,1),pointsFoundLC.Location(:,2),'gx');
            title('left Cathode');
            subplot(2,4,3)
            imshow(ImgRC);
            hold on;
            plot(pointsFoundRC.Location(:,1),pointsFoundRC.Location(:,2),'gx');
            title('right Cathode');
            subplot(2,4,4)
            imshow(ImgRA);
            hold on;
            plot(pointsFoundRA.Location(:,1),pointsFoundRA.Location(:,2),'gx');
            title('rightAnode');
            subplot(2,4,[3 4]);
            %TODE add path to YROI
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
    

end