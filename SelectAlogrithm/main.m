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

%-------------
result={};

fig=figure('visible','on');

listBox = uicontrol('style','listbox',...
    'String',{'X_Cathode','X_Anode','Y_Cathode','Y_Anode'},...
    'Position',[20 340 100 50],...
    'Callback',@getSelectedType...
    );
numberOfPictures = uicontrol('style','edit',...
    'Position',[20 200 100 20],...
    'Callback',@getNumberOfPictures...
    );
buttonNextPicture = uicontrol('style','pushbutton');
set(buttonNextPicture,'position',[1 1,120,20])
set(buttonNextPicture,'string','Next Picture')
set(buttonNextPicture,'callback',{@nextPicture,app,result})

function nextPicture(object,~,app,result)
i = randi([1,200],1,1);
img= app.ImageSelection.Slices_5.X_ROI.narrowCathodeROI{i,1};
imshow(img);
[x,y] = getpts;
%result = get('result');
assignin('caller','result',[evalin('caller','result');[x,y],{img}]);
end
function getNumberOfPictures(source,event)
source.String;
end
function getSelectedType(source,event)
source.Value;
end

