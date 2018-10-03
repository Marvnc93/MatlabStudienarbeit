
%Image Augmentation and Corner Detection
%main Folder needs to be added to the Path
%use clear if you want to use another mat file during runtime

% if exist('app','var') ==0
%     [file,path] = uigetfile('*.mat');0
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
scoreRange=12;
minElectrodeDistance =10;
drawFigures=false;
%% LOAD ROI USER POINTS
for i=1:size(Directory,1)
    file={load(fullfile(pathROI, directories{1,i}))};
    file = file{1}.result;
    rOIWithWrongUserPoints=[rOIWithWrongUserPoints;file(2:end,:)];
    %%clean up files -> anode 15 inputs cathode 15
end
for i=1:size(rOIWithWrongUserPoints,1)
    if rOIWithWrongUserPoints{i,4} =="Cathode"
        if numel(rOIWithWrongUserPoints{i,1})==30
            rOIandUserPoints =[rOIandUserPoints;rOIWithWrongUserPoints(i,:),15];
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
[algorithmCell] = CreateAlgorithmCell();
cell ={"preprocessing","preprocessingMode","imageSmoothen","imageSmoothenMode",...
    "imageSharpen","binarize","binarizeMode","structure","structureMode","structureShape","algorithm","algorithmShape"};
% 2 because first line is text
%for o=2:size(algorithmCell,1)

for o=2:2
    o
    if mod(o,25)==0
        o
    end
    for i=1:length(rOIandUserPoints)
    %for i=12:12
        Img = rOIandUserPoints{i,2};
        OrigImg =Img;
        numPoints = rOIandUserPoints{i,5};
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
        detectionFilterSize = algorithmCell{o,14};
        detectedPoints = detectHarrisFeatures(Img,'Filtersize',detectionFilterSize);
        
        %Get Force Points
        forcedPoints = GetAllPoints(detectedPoints,numPoints,minElectrodeDistance);
        %Get Quality Points
        qualityPoints = GetQualityPoints(Img,detectionFilterSize,0.08);
        %Freq points from the unaltered image
        freqPoints = GetPointsFromFreq(OrigImg,detectedPoints,minElectrodeDistance,i);
        %Freq points from the altered image
        freqPointsAlter = GetPointsFromFreq(Img,detectedPoints,minElectrodeDistance,i);
        %% Get Score
        rOIandUserPoints{i,6}= CalculateScore(forcedPoints,rOIandUserPoints{i,1},scoreRange);
        rOIandUserPoints{i,7}= CalculateScore(freqPoints,rOIandUserPoints{i,1},scoreRange);
        rOIandUserPoints{i,8}= CalculateScore(freqPointsAlter,rOIandUserPoints{i,1},scoreRange);
        %Points found without image augmentation
%        rOIandUserPoints{i,6} = CalculateScore(pointsFound.Location,rOIandUserPoints{i,1},pointRange);
        %Points found with image augmentation
        %rOIandUserPoints{i,6} = CalculateScore(pointsFoundAdj.Location,rOIandUserPoints{i,1},pointRange);
        
        %% Loop for Images
        if drawFigures==true
            fig = figure('visible','off',...
                'Position',[500 300 900 400]);
            subplot(1,2,1)
            imshow(Img);
            %Orig Points
            hold on;
            origPoints = detectedPoints.selectStrongest(15);
            plot(origPoints.Location(:,1),origPoints.Location(:,2),'gx');
            subplot(1,2,2)
            imshow(Img);
%             %Frequency Points
%             hold on;
%             plot(freqPoints(:,1),freqPoints(:,2),'rx');
            %Forced Points
            hold on;
            plot(forcedPoints(:,1),forcedPoints(:,2),'yx');
            % User points marker
            %hold on;
            %plot(rOIandUserPoints{i,1}(:,1),rOIandUserPoints{i,1}(:,2),'g+');
            %User points circles
%             for k = 1:numel(rOIandUserPoints{i,1}(:,1))
%                 centers=[rOIandUserPoints{i,1}(:,1),rOIandUserPoints{i,1}(:,2)];
%                 viscircles(centers,scoreRange*ones(size(centers(:,1))),'Color','g','LineStyle','-','LineWidth',0.1);
%             end
                
            
            
            title(strcat('Points Found Force:',int2str(rOIandUserPoints{i,6}),...
                ' Freq ',int2str(rOIandUserPoints{i,7})));
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\IAandCD\',int2str(i),'.png'));
            close all
        end
    end
[xafo,xcfo,yafo,ycfo]=ProcessScore(rOIandUserPoints,6);
    algorithmCell{o,15} = xafo;
    algorithmCell{o,16} = xcfo;
    algorithmCell{o,17} = yafo;
    algorithmCell{o,18} = ycfo;
[xafr,xcfr,yafr,ycfr]=ProcessScore(rOIandUserPoints,7);
    algorithmCell{o,19} = xafr;
    algorithmCell{o,20} = xcfr;
    algorithmCell{o,21} = yafr;
    algorithmCell{o,22} = ycfr;
[xaal,xcal,yaal,ycal]=ProcessScore(rOIandUserPoints,8);
    algorithmCell{o,23} = xaal;
    algorithmCell{o,24} = xcal;
    algorithmCell{o,25} = yaal;
    algorithmCell{o,26} = ycal;  
    

end
strcat(algorithm," Algorithm was used")

