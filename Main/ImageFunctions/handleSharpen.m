
function ImgOut = handleSharpen(cell,count,ImgIn)
if cell{count,7}=="on"
    filt = fspecial('laplacian',cell{count,10});
    ImgAdj = imfilter(ImgIn,filt);
    ImgOut =imsubtract(ImgIn,ImgAdj);
else
    ImgOut=ImgIn;
end
