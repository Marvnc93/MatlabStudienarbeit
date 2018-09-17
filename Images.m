%% Otsus Method

I =imread('coins.png');
level = graythresh(I)
BW = imbinarize(I,level);
ownlvl =0.38;
Own = imbinarize(I,ownlvl);
fig = figure();
subplot(1,3,1)
imshow(I);
t1=title('Original Image');
t1.FontSize=11;
t1.FontName = 'Arial';
subplot(1,3,2)
imshow(BW);
t2=title({'Seperation with Otsus Method',strcat('Level = ',int2str(ceil(level*255)))})
t2.FontSize=11;
t2.FontName = 'Arial';
subplot(1,3,3)
imshow(Own);
t3=title({'Seperation with manual Level selection',strcat('Level = ',int2str(ceil(ownlvl*255)))})
t3.FontSize=11;
t3.FontName = 'Arial';

%% LUT
% I =imread('coins.png');
% 
% imhist(I)
