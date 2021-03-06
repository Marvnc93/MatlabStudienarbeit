%main Folder needs to be added to the Path
%use clear if you want to use another mat file during runtime
if exist('app','var') ==0
    [file,path] = uigetfile('D:\Studienarbeit\ProgrammFolder\Apptest.mat',...
        'SelcectApptest');
    app = load(fullfile(path,file),'app');
    app =app.app;
end

global listBox;
global numberOfPictures;
global result;
global imgCounterText;
global textNumberOfPictures;
global fig;
clear n;
result={'UserXY Values','Image','X or Y','Cathode or Anode'};
fig=figure('visible','on',...
    'Position',[200 200 600 600]);

imgCounterText = uicontrol('style','text',...
    'Position',[20 560 400 40],...
    'String','Select type',...
    'HorizontalAlignment','left',...
    'FontSize',20,...
    'FontName','Arial');
%Box which lists all posible Types
listBox = uicontrol('style','listbox',...
    'String',{'X Cathode','X Anode','Y Cathode','Y Anode'},...
    'Position',[20 400 200 160],...
            'FontSize',20,...
    'FontName','Arial');

%Edit Box +Text where the number of pictures to be worked is specified
textNumberOfPictures = uicontrol('style','text',...
    'Position',[20 300 180 40],...
    'String','Amount',...
        'FontSize',20,...
    'FontName','Arial',...
    'HorizontalAlignment','left');
numberOfPictures = uicontrol('style','edit',...
    'Position',[20 200 100 40],...
    'FontSize',20,...
    'FontName','Arial');

%Function which loads the next picture
%Also it switches from intro ->select
buttonNextPicture = uicontrol('style','pushbutton',...
    'Position',[30 20 240 40],...
    'String',{'Start'},...
    'FontSize',20,...
    'FontName','Arial',...
    'Callback',{@nextPicture,app},...
    'Visible','on');


function nextPicture(object,~,app)
object.String = 'Next Picture';
global listBox;
global numberOfPictures;
global result;
global imgCounterText;
global textNumberOfPictures;
global fig;
%use persistent for number of pictures
%{listBox.Visible,numberOfPictures.Visible} = {'off','off'};
listBox.Visible = 'off';
numberOfPictures.Visible = 'off';
textNumberOfPictures.Visible ='off';
persistent n
if isempty(n)
    n=str2double(numberOfPictures.String);
else
    n = n-1;
end
imgCounterText.String = strcat('Images left:  ',int2str(n));
if n==1
    object.String = 'Finish';
end
if n==0
    close(fig);
    save(strcat('D:\Studienarbeit\ProgrammFolder\ROIPoints\',int2str(randi([1,9999999],1,1)),'.mat'),'result');
    clear all;
else
    %Get the list and the amount of Selected Folders
    listSelected = app.FolderSelection.InputFolders.Selected_Values;
    amountSelected = numel(app.FolderSelection.InputFolders.Selected_Values);
    %Pick a random Folder
    i = randi([1,amountSelected],1,1);
    pickedFolder = app.ImageSelection.(listSelected{i});
    %Choose the struct fitting to the type choice made by the user in listBox
    [ROIXY,ROICathodeAnode,resultCA]=returnXYCathodeAnode();
    xyStruct = pickedFolder.(ROIXY);
    %For XY there are each 2 fitting structs (which are combined here) -> returnXYCathodeAnode
    typeStruct = [xyStruct.(ROICathodeAnode{1,1});xyStruct.(ROICathodeAnode{1,2})];
    %Clear type Struct from inapropriate Values
    cleanTypeStruct = deleteFalseROI(typeStruct);
    %Select a random picture
    j = randi([1,size(cleanTypeStruct,1)],1,1);
    img= cleanTypeStruct{j,1};
    imshow(img);
    %Get the user Input
    [x,y] = getpts;
    result = [result; [x,y],{img},{ROIXY},{resultCA}];
end
end
function [ROIXY,ROICathodeAnode,resultCA] = returnXYCathodeAnode()
global listBox;
selectInt = listBox.Value;
switch selectInt
    case 1
        ROIXY = 'X_ROI';
        ROICathodeAnode = {'narrowCathodeROI','broadCathodeROI'};
        resultCA  ='Cathode';
    case 2
        ROIXY = 'X_ROI';
        ROICathodeAnode = {'narrowAnodeROI','broadAnodeROI'};
        resultCA  ='Anode';
    case 3
        ROIXY = 'Y_ROI';
        ROICathodeAnode = {'leftCathodeROI','rightCathodeROI'};
        resultCA  ='Cathode';
    case 4
        ROIXY = 'Y_ROI';
        ROICathodeAnode = {'leftAnodeROI','rightAnodeROI'};
        resultCA  ='Anode';
    otherwise
        'Case not legit'
end
end

function cleanROI = deleteFalseROI(ROI)
sizeROI = size(ROI,1);
cleanROI=[];
for i=1:sizeROI
    if ROI{i,3}==1
        cleanROI = [cleanROI;ROI(i,:)];
    end
end
end