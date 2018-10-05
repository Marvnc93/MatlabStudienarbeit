load('C:\Users\marvn\Desktop\MatlabStudienarbeit\For Paper\cathodeSample.mat');
Img = lessago;
meangrey = mean(mean(Img),2)/255
ImgAdj =imadjust(Img,[meangrey 1],[0 1]);
S= transpose(fspecial('sobel'));
G = fspecial('gaussian',7,2);
ImgAdj = imfilter(ImgAdj,S);
ImgAdj = imfilter(ImgAdj,G);
% shape = 'rectangle';
% len =[5 7];
% SE = strel(shape,len);
% 
% ImgAdj=imerode(ImgAdj,SE);

pointsFound = detectHarrisFeatures(ImgAdj,'Filtersize',7);
pointsFound=GetAllPoints(pointsFound,15,12);
subplot(1,2,1)
imshow(Img);
subplot(1,2,2)
imshow (ImgAdj);
hold on
plot(pointsFound(:,1),pointsFound(:,2),'gx','MarkerSize',12,'LineWidth',2)