function pointsFound = GetPoints(Img,settings,numPoints)
        greyCutoff = settings{1};
        structureElement = settings{2};
        structureElementShape=settings{3};
        sharpen = settings{4};
        algorithm = settings{5};
        

        %% Preprocessing
        Img = handlePreprocessing(algorithmCell,o,Img);
        
        %% Early Sobel
        Img = handleEarlySobel(algorithmCell,o,Img);
        
        %% ImageSmoothing
        Img = handleSmoothing(algorithmCell,o,Img);
        
        %% ImageSharpen
        Img = handleSharpen(algorithmCell,o,Img);
        
        %% Binarize
        Img = handleBinarize(algorithmCell,o,Img);
        
        %% Structural Operations        
        Img = handleStructurals(algorithmCell,o,Img);
        
        %% CornerDetection 
        allPoints = detectHarrisFeatures(Img,'Filtersize',7);
        pointsFound = GetAllPoints(allPoints,numPoints,10);
    end
