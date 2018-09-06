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
for i=1:size(Directory,1)
    file={load(fullfile(pathROI, directories{1,i}))};
    file = file{1}.result;
    rOIandUserPoints=[rOIandUserPoints;file(2:end,:)];
end
%Greyscale cutting
for i=1:length(rOIandUserPoints)
Img = rOIandUserPoints{i,2};
greyValue =mean(Img,2);
%[row,col] = size(Img);
%package_grayvalue = max(max(Img(:,col-50:col)));
%ImgAdj = imadjust(Img, [double(package_grayvalue)/255,1],[0 1]);
greyCutoff = mean(greyValue);
ImgAdj = imadjust(Img,[greyCutoff/255,1],[0 1]);
SE = strel('rectangle',[3,10]);
ImgAdj = imclose(ImgAdj,SE);
greyValueAdj = mean(ImgAdj,2); 
fig = figure('visible','off',...
    'Position',[500 300 500 700]);
            subplot(2,2,1)
            imshow(Img);
            title('Image without Adjustment');
            subplot(2,2,2)
            imshow(ImgAdj);
            title('Image after Adjustment');
            subplot(2,2,[3 4]);
            plot(greyValue);
            hold on;
            title('Columnwise Greyscale');
            plot(greyValueAdj,'g');
            saveas(fig,strcat(path,filesep,'IAandCD\',rOIandUserPoints{i,3},rOIandUserPoints{i,4},int2str(i),'.png'));
end
            %Smooth GreyScale Plot
%     %morphologie closing
SE = strel('rectangle',10);
ImgAdj = imclose(ImgAdj,SE);
%     %detect Harris Features and select 25 best
%     points_anode_top = detectHarrisFeatures(ROI_anode_top,'FilterSize',5);
%     points_anode_top = points_anode_top.selectStrongest(25).Location;
img=2;