
function ImgOut = handleSharpen(cell,count,ImgIn)
if cell{count,7}=="on"
    filt = fspecial('laplacian',cell{count,10});
    ImgOut = imfilter(ImgIn,filt);
else
    ImgOut=ImgIn;
end
