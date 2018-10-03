function [] = appstart(app,Test_Mode)
%APPSTART Summary of this function goes here
%   Detailed explanation goes here

addpath([pwd filesep 'AppImages']);
addpath([pwd filesep 'CellSelection']);
addpath([pwd filesep 'ImageImport']);
addpath([pwd filesep 'CornerDetection']);
addpath([pwd filesep 'SelectAlgorithm']);

imshow('AppImages/IWF Logo.png', 'Parent', app.IWF_Logo_1);
imshow('AppImages/IWF Logo.png', 'Parent', app.IWF_Logo_2);

imshow('AppImages/xMinLength.png', 'Parent', app.ShowHelperPreview);

CreateTable(app,"Start");
if Test_Mode == true
    app.FolderSelection.Input_Path = 'D:\Studienarbeit\Input';
    app.InputDataFolderEditField.Value = app.FolderSelection.Input_Path;
    
    app.FolderSelection.Output_Path = 'D:\Studienarbeit\Output'; 
    app.OutputDataFolderEditField.Value = app.FolderSelection.Output_Path;
    
    app.FolderSelection.Programm_Path = 'D:\Studienarbeit\ProgrammFolder'; 
    app.ProgrammDataFolderEditField.Value = app.FolderSelection.Programm_Path;
    
    ListFolders(app);
end

% Fill struct for the case no user prefs are selected
app.ImageSelection.ImportSettings.xMinLength = ceil(app.MinimalelectrodelengthpxSlider.Value);
app.ImageSelection.ImportSettings.xDistToMiddle =  ceil(app.DistancefromcornerimagesSlider.Value);
app.ImageSelection.ImportSettings.yMinLength =   ceil(app.MInmalelectrodelengthpxSlider.Value);
app.ImageSelection.ImportSettings.yDistToEdge =  ceil(app.MinimaldistancetoedgepxSlider.Value);
app.ImageSelection.ImportSettings.zAmount =  ceil(app.NumerofPicturesSlider.Value);

end

