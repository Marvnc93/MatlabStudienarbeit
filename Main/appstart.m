function [] = appstart(app,Test_Mode)
%APPSTART Summary of this function goes here
%   Detailed explanation goes here

addpath([pwd filesep 'AppImages']);
addpath([pwd filesep 'CellSelection']);
addpath([pwd filesep 'ImageImport']);

imshow('AppImages/IWF Logo.png', 'Parent', app.IWF_Logo_1);
imshow('AppImages/IWF Logo.png', 'Parent', app.IWF_Logo_2);

imshow('AppImages/xMinLength.png', 'Parent', app.ShowHelperPreview);

CreateTable(app,"Start");
if Test_Mode == true
    app.FolderSelection.Input_Path = 'D:\Studienarbeit\Input';
    app.InputDataFolderEditField.Value = app.FolderSelection.Input_Path;
    
    app.FolderSelection.Output_Path = 'D:\Studienarbeit\Output'; 
    app.OutputDataFolderEditField.Value = app.FolderSelection.Output_Path;
    ListFolders(app);
end

% Fill struct for the case no user prefs are selected
app.ImageSelection.ImportSettings.xMinLength = ceil(app.MinimalelectrodelengthSlider.Value);
app.ImageSelection.ImportSettings.xDistToMiddle =  ceil(app.DistancefrommiddlepictureSlider.Value);
app.ImageSelection.ImportSettings.yMinLength =   ceil(app.MInmalelectrodelengthSlider.Value);
app.ImageSelection.ImportSettings.yDistToEdge =  ceil(app.MinimaldistancetoedgeSlider.Value);
app.ImageSelection.ImportSettings.zAmount =  ceil(app.NumerofPicturesSlider.Value);

end

