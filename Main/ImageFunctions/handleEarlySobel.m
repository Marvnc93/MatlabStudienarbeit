function ImgOut = handleEarlySobel(cell,count,ImgIn)
if cell{count,8}=="on" && cell{count,9}=="EarlySobel"
    sob = transpose(fspecial('Sobel'));
    ImgOut = conv2(ImgIn,sob);
else
    ImgOut=ImgIn;
end

end