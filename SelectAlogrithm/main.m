%Choose Number of Images per type
%Types are XCathode XAnode YCathode YAnode
%Saving of the different types
%1 mat for each picture with the image and the points
% -> easy to save and implement
% -> needs identifier for Type
if exist('app','var') ==0
    app = load('apptest_ROIX.mat','app');
    app =app.app;
end

global listBox;
global numberOfPictures;
global result;
result={'UserXY Values','Image','Selected Type','Number of Pictures'};
fig=figure('visible','on');
listBox = uicontrol('style','listbox',...
    'String',{'X Cathode','X Anode','Y Cathode','Y Anode'},...
    'Position',[150 340 150 50]...
    );
numberOfPictures = uicontrol('style','edit',...
    'Position',[150 200 100 20]...
    );
buttonNextPicture = uicontrol('style','pushbutton',...
    'Position',[150 20 120 20],...
    'String',{'Start'},...
    'Callback',{@nextPicture,app},...
    'Visible','on'...
    );

function nextPicture(object,~,app)
object.String = 'Next Picture';
global listBox;
global numberOfPictures;
global result;
%Get the list and the amount of Selected Folders
listSelected = app.FolderSelection.InputFolders.Selected_Values;
amountSelected = numel(app.FolderSelection.InputFolders.Selected_Values);
%Pick a random Folder
i = randi([1,amountSelected],1,1);
pickedFolder = app.ImageSelection.(listSelected{i});
%Choose the struct fitting to the type choice made by the user in listBox
[ROIXY,ROICathodeAnode]=returnXYCathodeAnode();
xyStruct = pickedFolder.(ROIXY);
%For XY there are each 2 fitting structs (which are combined here) -> returnXYCathodeAnode
typeStruct = [xyStruct.(ROICathodeAnode{1,1});xyStruct.(ROICathodeAnode{1,2})];
%Select a random picture
j = randi([1,size(typeStruct,1)],1,1);
img= typeStruct{j,1};
imshow(img);
[x,y] = getpts;
result = [result; [x,y],{img},{listBox.Value},{numberOfPictures.String}];
end
function [ROIXY,ROICathodeAnode] = returnXYCathodeAnode()
global listBox;
selectInt = listBox.Value;
switch selectInt
    case 1
        ROIXY = 'X_ROI';
        ROICathodeAnode = {'narrowCathodeROI','broadCathodeROI'};
    case 2
        ROIXY = 'X_ROI';
        ROICathodeAnode = {'narrowAnodeROI','broadAnodeROI'};
    case 3
        ROIXY = 'Y_ROI';
        ROICathodeAnode = {'leftCathodeROI','rightCathodeROI'};
    case 4
        ROIXY = 'Y_ROI';
        ROICathodeAnode = {'leftAnodeROI','rightAnodeROI'};
    otherwise
        'Case not legit'
end
end

