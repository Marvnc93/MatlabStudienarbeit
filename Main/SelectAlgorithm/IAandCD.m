
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
drawFigures=true;
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
for o=2:size(algorithmCell,1)
%for o=2:2
strcat("At ", num2str(o/size(algorithmCell,1)*100)," %")
    %quality = 0.02;
    minElectrodeDistance= algorithmCell{o,11};
    for i=1:length(rOIandUserPoints)
%         for i=1:1
        Img = rOIandUserPoints{i,2};
        OrigImg =Img;
        numPoints = rOIandUserPoints{i,5};
        %% Preprocessing
        Img = handlePreprocessing(algorithmCell,o,Img);
        
        %% Early Sobel
        %Removed after first run
        %Img = handleEarlySobel(algorithmCell,o,Img);
        
        %% ImageSmoothing
        Img = handleSmoothing(algorithmCell,o,Img);
        
        %% ImageSharpen
        Img = handleSharpen(algorithmCell,o,Img);
        
        %% Binarize
        %Removed after first run
        %Img = handleBinarize(algorithmCell,o,Img);
        
        %% Structural Operations
        %Removed after first run
        %Img = handleStructurals(algorithmCell,o,Img);
        
        %% CornerDetection
        detectionFilterSize = algorithmCell{o,9};
        detectedPoints = detectHarrisFeatures(Img,'Filtersize',detectionFilterSize);
        
        %Original Points
        origPoints = detectedPoints.selectStrongest(15).Location;
        %Get Force Points
        forcedPoints = GetAllPoints(detectedPoints,numPoints,minElectrodeDistance);
        %Get Quality Points
        %qualityPoints = GetQualityPoints(Img,detectionFilterSize,quality);
        %Freq points from the unaltered image
        freqPoints = GetPointsFromFreq(OrigImg,detectedPoints,minElectrodeDistance);
        %         %Freq points from the altered image
        %         freqPointsAlter = GetPointsFromFreq(Img,detectedPoints,minElectrodeDistance);
        %% Get Score
        rOIandUserPoints{i,6}= CalculateScore(forcedPoints,rOIandUserPoints{i,1},scoreRange);
        %rOIandUserPoints{i,7} = CalculateScore(qualityPoints,rOIandUserPoints{i,1},scoreRange);
        rOIandUserPoints{i,8}= CalculateScore(freqPoints,rOIandUserPoints{i,1},scoreRange);
        rOIandUserPoints{i,9}= CalculateScore(origPoints,rOIandUserPoints{i,1},scoreRange);
        %Points found without image augmentation
        %        rOIandUserPoints{i,6} = CalculateScore(pointsFound.Location,rOIandUserPoints{i,1},pointRange);
        %Points found with image augmentation
        %rOIandUserPoints{i,6} = CalculateScore(pointsFoundAdj.Location,rOIandUserPoints{i,1},pointRange);
        
        %% Loop for Images
        if drawFigures==true
            strcat("At image number: ",int2str(i),"/",int2str(length(rOIandUserPoints)))
%             strcat("At image number: ",int2str(o),"/",int2str(size(algorithmCell,1)))
            fig = figure('visible','off',...
                'Position',[500 300 1200 400]);
            subplot(1,4,1)
            imshow(Img);
            hold on;
            for k = 1:numel(rOIandUserPoints{i,1}(:,1))
                centers=[rOIandUserPoints{i,1}(:,1),rOIandUserPoints{i,1}(:,2)];
                viscircles(centers,scoreRange*ones(size(centers(:,1))),'Color','g','LineStyle','-','LineWidth',0.1);
            end
            %plot(forcedPoints(:,1),forcedPoints(:,2),'yx','MarkerSize',12,'LineWidth',2);
            title(strcat('#Points Force:',int2str(rOIandUserPoints{i,6})));
            
            subplot(1,4,2)
            imshow(Img);
            hold on;
            for k = 1:numel(rOIandUserPoints{i,1}(:,1))
                centers=[rOIandUserPoints{i,1}(:,1),rOIandUserPoints{i,1}(:,2)];
                viscircles(centers,scoreRange*ones(size(centers(:,1))),'Color','g','LineStyle','-','LineWidth',0.1);
            end
            %plot(qualityPoints(:,1),qualityPoints(:,2),'rx','MarkerSize',12,'LineWidth',2);
            title(strcat('#Points Quality:',int2str(rOIandUserPoints{i,7})));
            
            subplot(1,4,3)
            imshow(Img);
            hold on;
            for k = 1:numel(rOIandUserPoints{i,1}(:,1))
                centers=[rOIandUserPoints{i,1}(:,1),rOIandUserPoints{i,1}(:,2)];
                viscircles(centers,scoreRange*ones(size(centers(:,1))),'Color','g','LineStyle','-','LineWidth',0.1);
            end
            plot(freqPoints(:,1),freqPoints(:,2),'cx');%,'MarkerSize',12,'LineWidth',2);
            title(strcat('#Points Freq: ',int2str(rOIandUserPoints{i,8})));
            subplot(1,4,4)
            imshow(Img);
            hold on;
            for k = 1:numel(rOIandUserPoints{i,1}(:,1))
                centers=[rOIandUserPoints{i,1}(:,1),rOIandUserPoints{i,1}(:,2)];
                viscircles(centers,scoreRange*ones(size(centers(:,1))),'Color','g','LineStyle','-','LineWidth',0.1);
            end
            plot(origPoints(:,1),origPoints(:,2),'gx','MarkerSize',12,'LineWidth',2);
            title(strcat('#Points Orig: ',int2str(rOIandUserPoints{i,9})));
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\IAandCD\',int2str(i),'.png'));
            %saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\IAandCD\',int2str(o),'.png'));
            close all
        end
    end
    start = 11;
    [xaor,xcor,yaor,ycor]=ProcessScore(rOIandUserPoints,9);
    algorithmCell{o,start+1} = xaor;
    algorithmCell{o,start+2} = xcor;
    algorithmCell{o,start+3} = yaor;
    algorithmCell{o,start+4} = ycor;
    [xafo,xcfo,yafo,ycfo]=ProcessScore(rOIandUserPoints,6);
    algorithmCell{o,start+5} = xafo;
    algorithmCell{o,start+6} = xcfo;
    algorithmCell{o,start+7} = yafo;
    algorithmCell{o,start+8} = ycfo;
%     [xaqu,xcqu,yaqu,ycqu]=ProcessScore(rOIandUserPoints,7);
%     algorithmCell{o,start+9} = xaqu;
%     algorithmCell{o,start+10} = xcqu;
%     algorithmCell{o,start+11} = yaqu;
%     algorithmCell{o,start+12} = ycqu;
    [xafr,xcfr,yafr,ycfr]=ProcessScore(rOIandUserPoints,8);
    algorithmCell{o,start+13} = xafr;
    algorithmCell{o,start+14} = xcfr;
    algorithmCell{o,start+15} = yafr;
    algorithmCell{o,start+16} = ycfr;
%     
%     
%     
end
algorithmCell{1,start+20}=0;
algorithmCell(1,start+1:start+16) = {"xaor","xcor","yaor","ycor","xafo","xcfo","yafo","ycfo","xaqu","xcqu","yaqu","ycqu","xafr","xcfr","yafr","ycfr"};
strcat(algorithm," Algorithm was used")

