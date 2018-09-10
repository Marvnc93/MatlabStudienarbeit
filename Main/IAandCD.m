<<<<<<< HEAD
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
rOIandUserPoints = {};
%% CONFIG
algorithm = "SURF";
numPoints = 15;
%% LOAD ROI USER POINTS
for i=1:size(Directory,1)
    file={load(fullfile(pathROI, directories{1,i}))};
    file = file{1}.result;
    rOIandUserPoints=[rOIandUserPoints;file(2:end,:)];
end
%% Load img
for i=1:length(rOIandUserPoints)
Img = rOIandUserPoints{i,2};
%% Grey Cutoff
greyValue =mean(Img,2);
%greyCutoff = mean(greyValue(end-50:end));
greyCutOffValues = mean(greyValue)*1.8;
ImgAdj = imadjust(Img,[greyCutOffValues/255,1],[0 1]);
%ImgAdj = imadjust(ImgAdj);
greyValueAdj = mean(ImgAdj,2);
%% Morphologie closing
 SE = strel('rectangle',[5,10]);
 ImgAdj = imclose(ImgAdj,SE);
%% ImgSharpen
ImgAdj = imsharpen(ImgAdj);

%% Find Harrison Features 
if algorithm =="Harrison"
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

%% Find FAST Features
if algorithm == "FAST"
    pointsFound = detectFASTFeatures(Img);
    pointsFound = pointsFound.selectStrongest(numPoints);
    pointsFoundAdj = detectFASTFeatures(ImgAdj);
    pointsFoundAdj = pointsFoundAdj.selectStrongest(numPoints);
    
end
%% Find BRISK Features
if algorithm == "BRISK"
    pointsFound = detectBRISKFeatures(Img);
    pointsFound = pointsFound.selectStrongest(numPoints);
    pointsFoundAdj = detectBRISKFeatures(ImgAdj);
    pointsFoundAdj = pointsFoundAdj.selectStrongest(numPoints);
    
end

%% Loop for Images
fig = figure('visible','off',...
    'Position',[500 300 500 700]);
            
            subplot(2,2,1)
            imshow(Img);
            hold on;
            plot(pointsFound.Location(:,1),pointsFound.Location(:,2),'rx');
            
            title('Image without Adjustment');
            subplot(2,2,2)

            imshow(ImgAdj);
            hold on;
            plot(pointsFoundAdj.Location(:,1),pointsFoundAdj.Location(:,2),'gx');

            title('Image after Adjustment');
            subplot(2,2,[3 4]);
            plot(greyValue);
            hold on;
            title(rOIandUserPoints{i,4});
            plot(greyValueAdj,'g');
            
            
            saveas(fig,strcat(path,filesep,'IAandCD\',rOIandUserPoints{i,3},rOIandUserPoints{i,4},int2str(i),'.png'));
end
strcat(algorithm," Algorithm was used")
            %Smooth GreyScale Plot
%     %morphologie closing
%     %detect Harris Features and select 25 best
%     points_anode_top = detectHarrisFeatures(ROI_anode_top,'FilterSize',5);
%     points_anode_top = points_anode_top.selectStrongest(25).Location;
img=2;
=======
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
rOIandUserPoints = {};
%% CONFIG
algorithm = "SURF";
numPoints = 15;
%% LOAD ROI USER POINTS
for i=1:size(Directory,1)
    file={load(fullfile(pathROI, directories{1,i}))};
    file = file{1}.result;
    rOIandUserPoints=[rOIandUserPoints;file(2:end,:)];
end
%% Load img
for i=1:length(rOIandUserPoints)
Img = rOIandUserPoints{i,2};
%% Grey Cutoff
greyValue =mean(Img,2);
%greyCutoff = mean(greyValue(end-50:end));
greyCutOffValues = mean(greyValue)*1.8;
ImgAdj = imadjust(Img,[greyCutOffValues/255,1],[0 1]);
%ImgAdj = imadjust(ImgAdj);
greyValueAdj = mean(ImgAdj,2);
%% Morphologie closing
 SE = strel('rectangle',[5,10]);
 ImgAdj = imclose(ImgAdj,SE);
%% ImgSharpen
ImgAdj = imsharpen(ImgAdj);

%% Find Harrison Features 
if algorithm =="Harrison"
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

%% Find FAST Features
if algorithm == "FAST"
    pointsFound = detectFASTFeatures(Img);
    pointsFound = pointsFound.selectStrongest(numPoints);
    pointsFoundAdj = detectFASTFeatures(ImgAdj);
    pointsFoundAdj = pointsFoundAdj.selectStrongest(numPoints);
    
end
%% Find BRISK Features
if algorithm == "BRISK"
    pointsFound = detectBRISKFeatures(Img);
    pointsFound = pointsFound.selectStrongest(numPoints);
    pointsFoundAdj = detectBRISKFeatures(ImgAdj);
    pointsFoundAdj = pointsFoundAdj.selectStrongest(numPoints);
    
end

%% Loop for Images
fig = figure('visible','off',...
    'Position',[500 300 500 700]);
            
            subplot(2,2,1)
            imshow(Img);
            hold on;
            plot(pointsFound.Location(:,1),pointsFound.Location(:,2),'rx');
            
            title('Image without Adjustment');
            subplot(2,2,2)

            imshow(ImgAdj);
            hold on;
            plot(pointsFoundAdj.Location(:,1),pointsFoundAdj.Location(:,2),'gx');

            title('Image after Adjustment');
            subplot(2,2,[3 4]);
            plot(greyValue);
            hold on;
            title(rOIandUserPoints{i,4});
            plot(greyValueAdj,'g');
            
            
            saveas(fig,strcat(path,filesep,'IAandCD\',rOIandUserPoints{i,3},rOIandUserPoints{i,4},int2str(i),'.png'));
end
strcat(algorithm," Algorithm was used")
            %Smooth GreyScale Plot
%     %morphologie closing
%     %detect Harris Features and select 25 best
%     points_anode_top = detectHarrisFeatures(ROI_anode_top,'FilterSize',5);
%     points_anode_top = points_anode_top.selectStrongest(25).Location;
img=2;
>>>>>>> ddc3edfc865b3f4f3ce38bb943f7ce1e2c062b28
