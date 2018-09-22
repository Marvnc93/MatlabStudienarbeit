function ImgOut = handleBinarize(cell,count,ImgIn)
if cell{count,8}=="on"
    switch cell{count,9}
        case "Thresholding"
            ImgOut=imbinarize(ImgIn);
        case "Sobel"
            sob = transpose(fspecial('Sobel'));
            ImgOut = conv2(ImgIn,sob);
        case "EarlySobel"
            ImgOut=ImgIn;
        otherwise
            "ERROR in handleBinarize"
    end
else
    ImgOut=ImgIn;
end
