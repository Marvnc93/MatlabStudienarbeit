function pointsFound = GetPoints(Img,settings,numPoints)
        greyCutoff = settings{1};
        structureElement = settings{2};
        structureElementShape=settings{3};
        sharpen = settings{4};
        algorithm = settings{5};
        
        %% Grey Cutoff
        if greyCutoff=="on"
            greyCutOffValues = mean(mean(Img));
            Img = imadjust(Img,[greyCutOffValues/255,1],[0 1]);;
        end
        %% Morphologie closing
        if structureElement=="on"
            ses = structureElementShape;
            shape = ses{1,1};
            len =ses{1,2};
            SE = strel(shape,len);
            Img = imclose(Img,SE);
        end
        %% ImgSharpen
        if sharpen=="on"
            Img = imsharpen(Img);
        end
        %% Find Harrison Features
        if algorithm =="Harrison"
            pointsFound = detectHarrisFeatures(Img,'Filtersize',7);
            pointsFound = pointsFound.selectStrongest(numPoints);
            
        end
        %% Find ShiTomasi Features
        if algorithm =="ShiTomasi"
            pointsFound = detectHarrisFeatures(Img,'Filtersize',7);
            pointsFound = pointsFound.selectStrongest(numPoints);
        end
        %% Find SURF Features
        if algorithm =="SURF"
            pointsFound = detectSURFFeatures(Img);
            pointsFound = pointsFound.selectStrongest(numPoints);
        end
        %% Find BRISK Features
        if algorithm == "BRISK"
            pointsFound = detectBRISKFeatures(Img);
            pointsFound = pointsFound.selectStrongest(numPoints);
        end
    end
