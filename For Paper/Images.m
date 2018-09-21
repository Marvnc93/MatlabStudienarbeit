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
% pointsFound=GetAllPoints(pointsFound,14,12);
% subplot(1,2,1)
% imshow(I);
% subplot(1,2,2)
% imshow (ImgAdj);
% hold on
% plot(pointsFound(:,1),pointsFound(:,2),'gx')
%% LUT
% I =imread('rose.jpg');
% Lut = [repmat(uint8([0]),1,120),uint8(1:4:256),repmat(uint8([255]),1,72)];
% 
% J =intlut(I,Lut);
% subplot(1,3,1)
% imshow(I);
% subplot(1,3,2)
% plot(1:1:256,Lut);
% subplot(1,3,3)
% imshow (J);
%% Laplacian
% I =imread('corners.jpg');
% ImgAdj=I;
% filt = fspecial('laplacian',0.5);
% ImgAdj = imfilter(I,filt);
% ImgAdj =imsubtract(I,ImgAdj);
% pointsFound = detectHarrisFeatures(ImgAdj,'Filtersize',7);
% pointsFound=GetAllPoints(pointsFound,14,12);
% subplot(1,2,1)
% imshow(I);
% subplot(1,2,2)
% imshow (ImgAdj);
% hold on
% plot(pointsFound(:,1),pointsFound(:,2),'gx')
%% All operations
%trehsholding, grey value cutoff, gaussian smoothing, anisotropic diffusio
%Sobel, smooth with laplacian, erode, dialete

%Img1 = edge(crop,'Sobel','vertical');

I =imread('corners.jpg');
crop = imcrop(I,[60 60 100 100]);
ha = tight_subplot(3,3,[0.001 0.001],[.01 .01],[.03 .03]);
%% Threshold
axes(ha(1));
imshow(crop);
ylabel("Original",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold');
%% Threshold
axes(ha(2));
Img2=imbinarize(crop);
imshow(Img2);
ylabel("Thresholding",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold');
%% GreyCutoff
axes(ha(3));
cutoff = mean(mean(crop));
Img3=imadjust(crop,[cutoff/255 1],[0 1]);
imshow(Img3);
ylabel("GrayCutoff",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold');
%% Gausian Smoothing
axes(ha(4));
Img4 =imgaussfilt(crop,2);
imshow(Img4);
ylabel("Gaussian Smoothing",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold');
%% Anisotropic Diffusion
axes(ha(5));
Img5 = imdiffusefilt(crop,'NumberOfIterations',7);
imshow(Img5);
ylabel("Anisotropic Diffusion",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold');
%% Sobel
axes(ha(6));
Img6=edge(crop,'Sobel','vertical');
imshow(Img6);
ylabel("Sobel",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold')
%%Sharpen with Laplacian
axes(ha(7));
filt = fspecial('laplacian',0.5);
Imgfilt = imfilter(crop,filt);
Img7 =imsubtract(crop,Imgfilt);
imshow(Img7);
ylabel("Laplacian",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold')
%% Erosion
axes(ha(8));
se = strel('rectangle',[2 5]);
Img8= imclose(crop,se);
imshow(Img8);
ylabel("Erosion",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold')
%% Dilation
axes(ha(9));
se = strel('rectangle',[2 5]);
%Img9= imdilate(crop,se);
Img9 = imopen(crop,se);
imshow(Img9);
ylabel("Dilation",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.025, 0.5, 0],'FontWeight','bold')

















