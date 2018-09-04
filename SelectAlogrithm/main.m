%programmDir = 'D:\Studienarbeit\ProgrammFolder\';
if exist('app') ==0
app = loadDir('apptest_ROIX.mat');
app =app.app;
end

%-------------
fig=figure('visible','on');
button = uicontrol('style','pushbutton');
set(button,'position',[1 1,120,20])
set(button,'string','Next Picture')
set(button,'callback',{@nextPicture,app})
%app.ImageSelection.Slices_5.X_ROI{1,1}
%Choose Number of Images per type
%Types are XCathode XAnode YCathode YAnode
%Saving of the different types 
%1 mat for each picture with the image and the points
% -> easy to save and implement
% -> needs identifier for Type

result=[nextPicture(button)];
function result = nextPicture(object,~,app)
i = randi([1,200],1,1);
img= app.ImageSelection.Slices_5.X_ROI.narrowCathodeROI{i,1};
imshow(img);
[x,y] = getpts;
result = [x,y];
end