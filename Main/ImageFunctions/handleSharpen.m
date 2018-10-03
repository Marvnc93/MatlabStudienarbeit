
function ImgOut = handleSharpen(cell,count,ImgIn)
if cell{count,7}=="on"
    filt = fspecial('laplacian',0.25);
    ImgOut = imfilter(ImgIn,filt);
else
    ImgOut=ImgIn;
end
