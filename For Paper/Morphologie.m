Img = imread('corners.jpg');
maxImg = max(max(Img));
ImgB =imadjust(Img, [193*0.7/255 1],[0 1]);
SE = strel('rectangle',[5,1]);
ImgB=imbinarize(ImgB);
ImgB =imerode(ImgB,SE);
% se = strel('square',5);
% %closeBW = imclose(ImgB,se);
% closeBW = imerode(ImgB,se);
%could be interesting for outlook
closeBW = bwmorph(ImgB,'remove');
subplot(1,2,1)
%imhist(Img);
imshow(Img);
subplot(1,2,2)
imshow(ImgB);