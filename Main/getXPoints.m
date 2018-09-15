% this should call all function related to X
app = load('apptest.mat');
app =app.app;

ROI_extractionX(app)

selectedValues=app.FolderSelection.InputFolders.Selected_Values;
stepsForFigures =10;
drawFigures = false;
pointsFound = struct;
settings=load(strcat(app.FolderSelection.Programm_Path,'\settings.mat'));
settings=settings.settings;

% angle = extractAngle(app.ImageSelection.Slices_5.Z)
% actual_distance_narrow_Y = distance_narrow_Y*cos((90+image_acquisition_angle)/180*pi);
% actual_distance_broad_Y = distance_broad_Y*sin((90+image_acquisition_angle)/180*pi);
% actual_distance_narrow_X = distance_narrow_X * sin((90+image_acquisition_angle)/180*pi);
% actual_distance_broad_X = distance_broad_X*cos((90+image_acquisition_angle)/180*pi);

for i=1:length(selectedValues)
    app.Distances.(selectedValues{i}).PointsX = {"Narrow Cathode","Narrow Anode","Broad Cathode","Broad Anode"};
    app.Distances.(selectedValues{i}).DistancesX = {"Narrow raw","Narrow real", "Broad raw","Broad real"};
    angle = extractAngle(app.ImageSelection.(selectedValues{i}).Z);
    for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI),1)
        Point_extractionX(app,settings,selectedValues,drawFigures,stepsForFigures,j,i,"Narrow")
        InterpolatePointsX(app,selectedValues,drawFigures,stepsForFigures,j,i,"Narrow")
        CalcDistance(app,selectedValues,angle,j,i,"Narrow")
    end
        for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI),1)
        Point_extractionX(app,settings,selectedValues,drawFigures,stepsForFigures,j,i,"Broad")
        InterpolatePointsX(app,selectedValues,drawFigures,stepsForFigures,j,i,"Broad")
        CalcDistance(app,selectedValues,angle,j,i,"Broad")
    end
end

"sd"

