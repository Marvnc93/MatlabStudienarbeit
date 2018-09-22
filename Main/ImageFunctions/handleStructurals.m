function ImgOut = handleStructurals(cell,count,ImgIn)
if cell{count,10}=="on"
    ses = cell{count,12};
    shape = ses{1,1};
    len =ses{1,2};
    SE = strel(shape,len);
    switch cell{count,11}
        case "open"
            ImgOut=imopen(ImgIn,SE);
        case "close"
            ImgOut = imclose(ImgIn,SE);
        otherwise
                "ERROR in handleStructurals"
    end
else
    ImgOut=ImgIn;
end
end
