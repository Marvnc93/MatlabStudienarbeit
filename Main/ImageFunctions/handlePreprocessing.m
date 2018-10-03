function ImgOut = handlePreprocessing(cell,count,ImgIn)
if cell{count,1}=="on"
    switch cell{count,2}
        case "Otsu"
            ImgOut = imadjust(ImgIn);
        case "Mean"
            greyCutOffValues = mean(mean(ImgIn));
            ImgOut = imadjust(ImgIn,[greyCutOffValues/255,1],[0 1]);
        case "Quartile"
            maxImg = single(max(max(ImgIn)));
            ImgOut =imadjust(ImgIn, [maxImg*0.75/255 1],[0 1]);
        otherwise
            "ERROR in handlePreprocessing"
    end
else
    ImgOut=ImgIn;
end
