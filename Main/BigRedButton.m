clear all;
close all;

app = load('apptest.mat');
app =app.app;
ROI_extractionX(app);
"ROIX finished"
ROI_extractionY(app);
"ROIY finished"
getXPoints(app);
"XPoints finished"
getYPoints(app);
"YPoints finished"
"Wait"