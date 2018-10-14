load('C:\Users\marvn\Desktop\MatlabStudienarbeit\For Paper\cathodeSample.mat');
Img = lessago;

    filt = fspecial('laplacian',0.25);
    ImgAdj = imfilter(Img,filt);
    ImgAdj =imsubtract(Img,ImgAdj);
    pointsAdj = detectHarrisFeatures(ImgAdj);
    pointsStrAdj = pointsAdj.selectStrongest(15).Location;
    %pointsStrAdj = GetAllPoints(pointsAdj,15,10);
    points = detectHarrisFeatures(Img);
    pointsStr = points.selectStrongest(15).Location;
    subplot(1,2,1)
    imshow(ImgAdj)
    hold on;
    plot (pointsStrAdj(:,1),pointsStrAdj(:,2),'gx')
    subplot(1,2,2)
    imshow(ImgAdj)
    hold on;
    plot (pointsStr(:,1),pointsStr(:,2),'gx')