Img = imread('cathode.bmp');
Img = rgb2gray(Img);
cutoff = mean(mean(Img));
Img=imadjust(Img,[cutoff/255 1],[0 1]);
G = fspecial('gaussian',7,2);
Img = imfilter(Img,G);
% points = detectHarrisFeatures(Img,'Filtersize',7);
% points = points.selectStrongest(30);


imshow(Img);
% hold on;
% plot(points.Location(:,1),points.Location(:,2),'gx');