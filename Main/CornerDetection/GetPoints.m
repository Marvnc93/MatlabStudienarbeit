function pointsFound = GetPoints(Img,Settings,minDist)

        

        %% Preprocessing
        Img = handlePreprocessing(Settings,1,Img);
        
        %% Early Sobel
%        Img = handleEarlySobel(Settings,1,Img);
        
        %% ImageSmoothing
        Img = handleSmoothing(Settings,1,Img);
        
        %% ImageSharpen
        Img = handleSharpen(Settings,1,Img);
        
        %% Binarize
%        Img = handleBinarize(Settings,1,Img);
        
        %% Structural Operations        
%        Img = handleStructurals(Settings,1,Img);
        
        %% CornerDetection 
        FilterSize = Settings{9};
        allPoints = detectHarrisFeatures(Img,'Filtersize',FilterSize);
        
        %%Point Method
        switch Settings{12}
            case "Orig"
                pointsFound = detectHarrisFeatures(Img);
                pointsFound = pointsFound.selectStrongest(15).Location;
            case "Freq"
                pointsFound = GetPointsFromFreq(Img,allPoints,minDist);
            case "Quality"
                pointsFound = GetQualityPoints(Img,FilterSize,0.045);
            case "Force"
                pointsFound = GetAllPoints(allPoints,15,minDist);
            otherwise
                "Error"
        end
    end
