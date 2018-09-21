Img = imread('corners.jpg');
res ={};
for i=1:10000;
    res(1,i) = {detectMinEigenFeatures(Img)};
    res(2,i) = {detectHarrisFeatures(Img)};
end
