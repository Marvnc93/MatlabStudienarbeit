load('C:\Users\marvn\Desktop\MatlabStudienarbeit\For Paper\cathodeSample.mat');
load('C:\Users\marvn\Desktop\MatlabStudienarbeit\For Paper\YcathodeSample.mat');
Img = app.ImageSelection.Slices_7.Y_ROI.rightCathodeROI{100};
meangrey = mean(mean(Img),2)/255;
ImgAdj =imadjust(Img,[meangrey 1],[0 1]);
ImgAdj = imcrop(ImgAdj,[200 100 100 300] );
ImgAiso = imdiffusefilt(ImgAdj,'NumberOfIterations',5);
ImgGauss = imgaussfilt(ImgAdj,2,'FilterSize',7);




pointsAiso = detectHarrisFeatures(ImgAiso);
%pointsAisoAdj = GetPointsFromFreq(ImgAiso,pointsAiso,10);
pointsAisoAdj = pointsAiso.selectStrongest(15).Location;
%pointsAisoAdj = GetAllPoints(pointsAiso,15,10);
pointsGauss = detectHarrisFeatures(ImgGauss);
%pointsGaussStr = GetPointsFromFreq(ImgGauss,pointsGauss,10);
pointsGaussStr=pointsGauss.selectStrongest(15).Location;
subplot(1,2,1)
imshow(ImgAiso)
hold on;
plot (pointsAisoAdj(:,1),pointsAisoAdj(:,2),'cx','MarkerSize',12,'LineWidth',2)
[x,y] = getpts;
subplot(1,2,2)
imshow(ImgGauss)
hold on;
plot (pointsGaussStr(:,1),pointsGaussStr(:,2),'cx','MarkerSize',12,'LineWidth',2)

%[3.6559981e-05] [4.6617074e-06]