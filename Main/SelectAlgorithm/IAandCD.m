
%Image Augmentation and Corner Detection
%main Folder needs to be added to the Path
%use clear if you want to use another mat file during runtime

% if exist('app','var') ==0
%     [file,path] = uigetfile('*.mat');
%     app = load(fullfile(path,file),'app');
%     app =app.app;
% end
path = 'D:\Studienarbeit\ProgrammFolder';
pathROI = strcat(path, '\ROIPoints');%change to app....Program_Path\ROIPoints
Directory = dir(pathROI);
Directory=Directory(~ismember({Directory.name},{'.','..'}));
directories={Directory.name};
rOIWithWrongUserPoints={};
rOIandUserPoints = {};
%% CONFIG
%algorithm = "SURF";
pointRange=10;
drawFigures=false;
%% LOAD ROI USER POINTS
for i=1:size(Directory,1)
    file={load(fullfile(pathROI, directories{1,i}))};
    file = file{1}.result;
    rOIWithWrongUserPoints=[rOIWithWrongUserPoints;file(2:end,:)];
    %%clean up files -> anode 15 inputs cathode 14
end
for i=1:size(rOIWithWrongUserPoints,1)
    if rOIWithWrongUserPoints{i,4} =="Cathode"
        if numel(rOIWithWrongUserPoints{i,1})==28
            rOIandUserPoints =[rOIandUserPoints;rOIWithWrongUserPoints(i,:),14];
        end
    end
    if rOIWithWrongUserPoints{i,4} =="Anode"
        if numel(rOIWithWrongUserPoints{i,1})==30
            rOIandUserPoints =[rOIandUserPoints;rOIWithWrongUserPoints(i,:),15];
        end
    end
end
%Need a function to create a matrix with all the different combinations
%results can be saved in the resulting matrix
%% Create Algorithm Cell
[algorithmCell,greyCutoff,structureElement,structureElementShape,sharpen,algorithms,grouping] = CreateAlgorithmCell();

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
            len =ses{1,2};
            SE = strel(shape,len);
            ImgAdj = imclose(ImgAdj,SE);
        end
        %% Apply Gaussfilter
        if grouping=="Gauss"
            H = fspecial('gaussian',5,2);
            ImgAdj = imfilter(ImgAdj,H);
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
            
            
            saveas(fig,strcat(path,filesep,'IAandCD\',int2str(i),rOIandUserPoints{i,3},rOIandUserPoints{i,4},'.png'));
        end
    end
    [xa,xc,ya,yc]=ProcessScore(rOIandUserPoints);
    algorithmCell{o,7} = xa;
    algorithmCell{o,8} = xc;
    algorithmCell{o,9} = ya;
    algorithmCell{o,10} = yc;
    %algorithmCell{o,7} = CalculateScore(pointsFoundAdj.Location,rOIandUserPoints{i,1},pointRange);
end
strcat(algorithm," Algorithm was used")
%Smooth GreyScale Plot
%     %morphologie closing
%     %detect Harris Features and select 25 best
%     points_anode_top = detectHarrisFeatures(ROI_anode_top,'FilterSize',5);
%     points_anode_top = points_anode_top.selectStrongest(25).Location;
img=2;
