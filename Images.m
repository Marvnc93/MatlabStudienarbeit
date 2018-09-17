%% Otsus Method

% I =imread('coins.png');
% level = graythresh(I)
% BW = imbinarize(I,level);
% ownlvl =0.38;
% Own = imbinarize(I,ownlvl);
% fig = figure();
% subplot(1,3,1)
% imshow(I);
% t1=title('Original Image');
% t1.FontSize=11;
% t1.FontName = 'Arial';
% subplot(1,3,2)
% imshow(BW);
% t2=title({'Seperation with Otsus Method',strcat('Level = ',int2str(ceil(level*255)))})
% t2.FontSize=11;
% t2.FontName = 'Arial';
% subplot(1,3,3)
% imshow(Own);
% t3=title({'Seperation with manual Level selection',strcat('Level = ',int2str(ceil(ownlvl*255)))})
% t3.FontSize=11;
% t3.FontName = 'Arial';
%% Gauss & Anisotropic
% I =imread('corners.jpg');
% ImgAdj=I;
% ImgAdj =imadjust(ImgAdj);
% S= transpose(fspecial('sobel'));
% G = fspecial('gaussian',7,2);
% ImgAdj = imfilter(ImgAdj,S);
% ImgAdj = imdiffusefilt(ImgAdj,'NumberOfIterations',3);
% ImgAdj = imfilter(ImgAdj,G);
% SE = strel('square',4);
% ImgAdj = imerode(ImgAdj,SE);
% pointsFound = detectHarrisFeatures(ImgAdj,'Filtersize',7);
% pointsFound = pointsFound.selectStrongest(14);
% subplot(1,2,1)
% imshow(I);
% subplot(1,2,2)
% imshow (ImgAdj);
% hold on
% plot(pointsFound.Location(:,1),pointsFound.Location(:,2),'gx')
%% LUT
I =imread('rose.jpg');
Lut = [repmat(uint8([0]),1,120),uint8(1:4:256),repmat(uint8([255]),1,72)];

J =intlut(I,Lut);
subplot(1,3,1)
imshow(I);
subplot(1,3,2)
plot(1:1:256,Lut);
subplot(1,3,3)
imshow (J);
