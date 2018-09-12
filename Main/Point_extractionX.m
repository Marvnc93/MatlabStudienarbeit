%function Point_extractionX(app)
function Point_extractionX()
%POINT_EXTRACTIONX Summary of this function goes here
%   Detailed explanation goes here
app = load('apptest.mat');
app =app.app;

for o=1:size(algorithmCell,1)
    algorithm = algorithms{o};
    for i=1:length(rOIandUserPoints)
        Img = rOIandUserPoints{i,2};
        greyValue =mean(Img,2);
        numPoints = rOIandUserPoints{i,5};
        %% Grey Cutoff
        if greyCutoff{o}=="on"
            greyCutOffValues = mean(greyValue);
            ImgAdj = imadjust(Img,[greyCutOffValues/255,1],[0 1]);
        else
            ImgAdj=Img;
        end
        %% Morphologie closing
        if structureElement{o}=="on"
            ses = structureElementShape{o};
            shape = ses{1,1};
            size =ses{1,2};
            SE = strel(shape,size);
            ImgAdj = imclose(ImgAdj,SE);
        end
        %% ImgSharpen
        if sharpen{o}=="on"
            ImgAdj = imsharpen(ImgAdj);
        end
        greyValueAdj = mean(ImgAdj,2);
        %% Find Harrison Features
        if algorithm =="Harrison"
            pointsFound = detectHarrisFeatures(Img,'Filtersize',7);
            pointsFound = pointsFound.selectStrongest(numPoints);
            pointsFoundAdj = detectHarrisFeatures(ImgAdj,'Filtersize',7);
            pointsFoundAdj = pointsFoundAdj.selectStrongest(numPoints);
        end
        %% Find ShiTomasi Features
        if algorithm =="ShiTomasi"
            pointsFound = detectHarrisFeatures(Img,'Filtersize',7);
            pointsFound = pointsFound.selectStrongest(numPoints);
            pointsFoundAdj = detectHarrisFeatures(ImgAdj,'Filtersize',7);
            pointsFoundAdj = pointsFoundAdj.selectStrongest(numPoints);
        end
        %% Find SURF Features
        if algorithm =="SURF"
            pointsFound = detectSURFFeatures(Img);
            pointsFound = pointsFound.selectStrongest(numPoints);
            pointsFoundAdj = detectSURFFeatures(ImgAdj);
            pointsFoundAdj = pointsFoundAdj.selectStrongest(numPoints);
        end
        %% Find BRISK Features
        if algorithm == "BRISK"
            pointsFound = detectBRISKFeatures(Img);
            pointsFound = pointsFound.selectStrongest(numPoints);
            pointsFoundAdj = detectBRISKFeatures(ImgAdj);
            pointsFoundAdj = pointsFoundAdj.selectStrongest(numPoints);
        end
        %% Get Score
        %Points found without image augmentation
%        rOIandUserPoints{i,6} = CalculateScore(pointsFound.Location,rOIandUserPoints{i,1},pointRange);
        %Points found with image augmentation
        rOIandUserPoints{i,6} = CalculateScore(pointsFoundAdj.Location,rOIandUserPoints{i,1},pointRange);
        
        %% Loop for Images
        if drawFigures==true
            fig = figure('visible','off',...
                'Position',[500 300 500 700]);
            
            subplot(2,2,1)
            imshow(Img);
            hold on;
            plot(pointsFound.Location(:,1),pointsFound.Location(:,2),'rx');
            hold on;
            plot(rOIandUserPoints{i,1}(:,1),rOIandUserPoints{i,1}(:,2),'g+');
            title('Image without Adjustment');
            subplot(2,2,2)
            
            imshow(ImgAdj);
            hold on;
            plot(pointsFoundAdj.Location(:,1),pointsFoundAdj.Location(:,2),'rx');
            hold on;
            plot(rOIandUserPoints{i,1}(:,1),rOIandUserPoints{i,1}(:,2),'g+');
            
            title('Image after Adjustment');
            subplot(2,2,[3 4]);
            plot(greyValue);
            hold on;
            title(rOIandUserPoints{i,4});
            plot(greyValueAdj,'g');
            
            
            saveas(fig,strcat(path,filesep,'PointsX\',int2str(i),rOIandUserPoints{i,3},rOIandUserPoints{i,4},'.png'));
        end
    end
    %algorithmCell{o,7} = CalculateScore(pointsFoundAdj.Location,rOIandUserPoints{i,1},pointRange);
end



end

