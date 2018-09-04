%programmDir = 'D:\Studienarbeit\ProgrammFolder\';
loadDir = strcat('apptest_ROIX.mat');
j=1;
if exist('app') ==0
app = load(loadDir);
app =app.app;
end
%-------------
fig=figure('visible','on');
button = uicontrol('style','pushbutton');
set(button,'position',[1 1,120,20])
set(button,'string','Next Picture')
set(button,'callback',{@nextPicture,app,j})
%app.ImageSelection.Slices_5.X_ROI{1,1}
%Choose Number of Images per type
%Types are XCathode XAnode YCathode YAnode
%Saving of the different types 
%1 mat for each picture with the image and the points
% -> easy to save and implement
% -> needs identifier for Type
[x,y] = getpts;

function nextPicture(object,~,app,j)
test();
j=j+1;
end
function test()
i = randi([1,200],1,1)
img= app.ImageSelection.Slices_5.X_ROI.narrowCathodeROI{i,1};
imshow(img);
end