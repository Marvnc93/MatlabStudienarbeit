function   NewPointDetection()
%NEWPOINTDETECTION Summary of this function goes here
%   Detailed explanation goes here
Img =imread('C:\Users\marvn\Desktop\MatlabStudienarbeit\corners.jpg');

%meanGrey = mean(Img((size(Img,2)/2-50):(size(Img,2)/2+50)));
meanGrey=mean(Img,2);
meanGreyAdj = mean(meanGrey);
Img = imadjust(Img,[meanGreyAdj/255,1],[0 1]);
meanGrey=mean(Img,2);
x = transpose(1:length(meanGrey));
y = meanGrey*1.5;
[pks,locs] = findpeaks(y,'MinPeakDistance',10);
[M,I] = maxk(pks,14);
%Img = imadjust(Img,[80/255,1],[0 1]);
%Img =imadjust(Img);
%Img = imgaussfilt(Img,7);
%level = graythresh(Img)*1.2;
%BW = imbinarize(Img,level);
%fig = figure('visible','on');
subplot(1,2,1)
imshow(Img);
hold on;
plot(y,x);
hold on;
plot(M,x(locs(I)),'gx');
subplot(1,2,2);
plot(x,y);

end
