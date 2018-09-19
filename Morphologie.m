Img = imread('corners.jpg');
ImgB=imbinarize(Img);
se = strel('square',5);
%closeBW = imclose(ImgB,se);
closeBW = imerode(ImgB,se);
subplot(1,2,1)
imshow(ImgB);
subplot(1,2,2)
imshow(closeBW);