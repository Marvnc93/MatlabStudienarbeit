function varargout = ImageDisplay(varargin)
% ImageDisplay M-file for ImageDisplay.fig
%      IMAGEDISPLAY, by itself, creates a new IMAGEANALYSIS or raises the existing
%      singleton*.
%
%      H = IMAGEDISPLAY returns the handle to a new IMAGEANALYSIS or the handle to
%      the existing singleton*.
%
%      IMAGEDISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEDISPLAY.M with the given input arguments.
%
%      IMAGEDISPLAY('Property','Value',...) creates a new IMAGEDISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IMAGEDISPLAY_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IMAGEDISPLAY_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageAnalysis

% Last Modified by GUIDE v2.5 26-Nov-2008 15:07:31

% Begin initialization code - DO NOT EDIT  
gui_Singleton = 1;
coordinates= struct;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageDisplay_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageDisplay_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ImageAnalysis is made visible.
function ImageDisplay_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageAnalysis (see VARARGIN)

% Choose default command line output for ImageAnalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);
setappdata(0  , 'hIMaGui', gcf);
setappdata(gcf, 'i'      , 1);

% --- Outputs from this function are returned to the command line.
function varargout = ImageDisplay_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadPics.
function LoadPics_Callback(hObject, eventdata, handles)
% hObject    handle to LoadPics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hIMaGui = getappdata(0, 'hIMaGui');

[FileName,PathName] = uigetfile({'*.jpg';'*.tif';'*.bmp'},'Select .mat files','MultiSelect','on');% Select multifiles or Single file.
%Mutlifiles or single file (k=1)
if  iscell(FileName)
    k = max(size(FileName));
else
    k = 1;
    FileName={FileName};%Change String to string Array if select single file
end
setappdata(hIMaGui, 'PathName', PathName);
setappdata(hIMaGui, 'FileName', FileName);
setappdata(hIMaGui, 'k'       , k);
UpdateAxes;



function UpdateAxes

hIMaGui = getappdata(0, 'hIMaGui');
PathName = getappdata(hIMaGui, 'PathName');
FileName = getappdata(hIMaGui, 'FileName');
i = getappdata(hIMaGui, 'i');
%hAxes = findobj(hIMaGui, 'tag', 'axes1');
%axes(hAxes);
IM = imread(FileName{i});
imshow(IM);
[coordinates.x,coordinates.y] = getpts
title(FileName{i});


% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
% hObject    handle to Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hIMaGui = getappdata(0, 'hIMaGui');
i = getappdata(hIMaGui, 'i');
k = getappdata(hIMaGui, 'k');
if i < k 
i = i + 1;
setappdata(hIMaGui, 'i', i);
UpdateAxes;
else
    message = 'This is the last picture.';
    disp(message);
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%set(h,'Visible','off');
% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in Previous.
function Previous_Callback(hObject, eventdata, handles)
% hObject    handle to Previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hIMaGui = getappdata(0, 'hIMaGui');
i = getappdata(hIMaGui, 'i');
if i > 1 
i = i - 1;
setappdata(hIMaGui, 'i', i);
UpdateAxes;
else
    message = 'This is the first picture.';
    disp(message);
end


% --------------------------------------------------------------------
function ImageDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to ImageDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


