function  getXPoints(app)

% %% Debug
% if exist('app','var') ==0
%     app = load('D:\Studienarbeit\ProgrammFolder\appcomplete.mat');
%     app =app.app;
% end
selectedValues=app.FolderSelection.InputFolders.Selected_Values;
stepsForFigures =500;
drawFigures = true;
pointsFound = struct;
Settings=load(strcat(app.FolderSelection.Programm_Path,'\settings.mat'));
Settings=Settings.Settings;

% angle = extractAngle(app.ImageSelection.Slices_5.Z)
% actual_distance_narrow_Y = distance_narrow_Y*cos((90+image_acquisition_angle)/180*pi);
% actual_distance_broad_Y = distance_broad_Y*sin((90+image_acquisition_angle)/180*pi);
% actual_distance_narrow_X = distance_narrow_X * sin((90+image_acquisition_angle)/180*pi);
% actual_distance_broad_X = distance_broad_X*cos((90+image_acquisition_angle)/180*pi);

%% real part
for i=1:length(selectedValues)
            %for i=1:1
    i
    app.Distances.(selectedValues{i}).PointsX = {"Narrow Cathode","Narrow Anode","Broad Cathode","Broad Anode"};
    app.Distances.(selectedValues{i}).DistancesX = {"Narrow raw per Image","Narrow real per Image","Distances raw per point", "Distances real per point",...
        "Broad raw per image","Broad real per image","Distances Raw per point", "Distances Real per point"};
    app.Distances.(selectedValues{i}).ResultsX = {"Narrow","Broad"};
    %% angle needs to be applied in a different fashion for both sides!!!!!!!!
    angle = extractAngle(app.ImageSelection.(selectedValues{i}).Z);
        for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI),1)
            if mod(j,10)==0
                strcat("Narrow at: ",int2str(j),"/",int2str(size((app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI),1)))
            end
            Point_extractionX(app,Settings,selectedValues,drawFigures,stepsForFigures,j,i,"Narrow")
            CalcDistance(app,selectedValues,angle,j,i,"Narrow","X")
        end
    for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI),1)
        if mod(j,10)==0
            strcat("Broad at: ",int2str(j),"/",int2str(size((app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI),1)))
        end
        Point_extractionX(app,Settings,selectedValues,drawFigures,stepsForFigures,j,i,"Broad")
        CalcDistance(app,selectedValues,angle,j,i,"Broad","X")
    end
    StatisticDistancesX(app,selectedValues,drawFigures,stepsForFigures,i,"Narrow");
    StatisticDistancesX(app,selectedValues,drawFigures,stepsForFigures,i,"Broad");
end




"sd"

