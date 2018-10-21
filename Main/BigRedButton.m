%clear all;
close all;

% app = load('apptest.mat');
% app =app.app;
% ROI_extractionX(app);
% "ROIX finished"
% ROI_extractionY(app);
% "ROIY finished"


if exist('app','var') ==0
    app = load('D:\Studienarbeit\ProgrammFolder\appcomplete.mat');
    app =app.app;
end


getXPoints(app);
"XPoints finished"
getYPoints(app);
"YPoints finished"
"Wait"