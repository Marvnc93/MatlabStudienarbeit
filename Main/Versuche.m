if exist('app','var') ==0
    app = load('D:\Studienarbeit\ProgrammFolder\apptest_ROIX.mat');
    app =app.app;
end
Img=app.ImageSelection.Slices_5.X_ROI.narrowCathodeROI{3,1};
ImgB=imbinarize(Img,[170/255]);
fig =figure();
subplot(1,2,1)
imshow(ImgB);
subplot(1,2,2)
imhist(Img);
% % Histogram experiment close all clear all 
% g = Img;
% % read rgb image g = rgb2gray(g);
% %g = imread( ’ rice .png ’) ;
% % read greyscale image
% gf = imfilter(g,fspecial('average' ,[15 15]) ,'replicate');
% gth = g - (gf + 20) ;
% gbw = imbinarize(gth,0) ;
% subplot(1 ,4 ,1) , imshow(gbw);
% %set (gca , ’ xtick ’ ,[] , ’ytickMode ’ , ’ auto ’) ;
% subplot(1 ,4 ,2) , imhist(gf); title('avg filtered image');
% grid on 
% glog = imfilter(g,fspecial('log' ,[15 15]) ,'replicate');
% 
% %glog = imfilter(g, fspecial(’prewitt ’));
% %glog = imfilter(g, fspecial(’sobel ’) ) ;
% %glog = imfilter(g, fspecial(’laplacian ’));
% %glog = imfilter(g, fspecial(’gaussian ’) ) ;
% %glog = imfilter(g, fspecial(’unsharp ’) ) ;
% subplot(1 ,4 ,3) , imshow(gbw);
% set(gca,'xtick' ,[] ,'ytickMode','auto');
% subplot(1 ,4 ,4) , imhist(glog);
% title('filtered image');
% grid on 