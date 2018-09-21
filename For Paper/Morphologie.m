Img = imread('corners.jpg');
ImgB=imbinarize(Img);
% se = strel('square',5);
% %closeBW = imclose(ImgB,se);
% closeBW = imerode(ImgB,se);
%could be interesting for outlook
closeBW = bwmorph(ImgB,'remove');
subplot(1,2,1)
imshow(ImgB);
subplot(1,2,2)
imshow(closeBW);