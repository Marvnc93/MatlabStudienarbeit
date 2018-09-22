
function ImgOut = handleSmoothing(cell,count,ImgIn)
if cell{count,3}=="on"
    switch cell{count,4}
        case "Gauﬂ"
            G = fspecial('gaussian',cell{count,5}{1},cell{count,5}{2});
            ImgOut = imfilter(ImgIn,G);
        case "Anisotropic"
            ImgOut = imdiffusefilt(ImgIn,'NumberOfIterations',cell{count,6});
        otherwise
                "ERROR in handleSmoothing"
    end
else
    ImgOut=ImgIn;
end