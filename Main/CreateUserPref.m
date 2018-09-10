function [] = CreateUserPref(app)
%CREATEUSERPREF Summary of this function goes here
%   Detailed explanation goes here
%outputArg1 = inputArg1;
%outputArg2 = inputArg2;
Parameters.Input_Path = app.FolderSelection.Input_Path;
Parameters.Output_Path = app.FolderSelection.Output_Path;
=app.ImageSelection.ImportSettings.xMinLength
= app.ImageSelection.ImportSettings.xDistToMiddle
=
%['UserPrefsTemp.mat',pwd] = uiputfile('myprefs.mat');
%'UserPrefsTemp.mat' = uiputfile('myprefs.mat');
[file,path] = uiputfile('myprefs.mat');
save([path filesep file],'Parameters');
end

