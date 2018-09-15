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
for i=1:length(selectedValues)
    app.Distances.(selectedValues{i}).PointsX = {"Narrow Cathode","Narrow Anode","Broad Cathode","Broad Anode"};
    app.Distances.(selectedValues{i}).DistancesX = {"Narrow raw","Narrow real", "Broad raw","Broad real"};
    for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI),1)
        Point_extractionX(app,settings,selectedValues,drawFigures,stepsForFigures,j,i,"Narrow")
        InterpolatePointsX(app,selectedValues,drawFigures,stepsForFigures,j,i,"Narrow")
        CalcDistance(app,selectedValues,j,i,"Narrow")
    end
        for j=1:size((app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI),1)
        Point_extractionX(app,settings,selectedValues,drawFigures,stepsForFigures,j,i,"Broad")
        InterpolatePointsX(app,selectedValues,drawFigures,stepsForFigures,j,i,"Broad")
        CalcDistance(app,selectedValues,j,i,"Broad")
    end
end

"sd"

