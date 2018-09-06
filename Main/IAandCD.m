%Image Augmentation and Corner Detection
%main Folder needs to be added to the Path
%use clear if you want to use another mat file during runtime
if exist('app','var') ==0
    [file,path] = uigetfile('*.mat');
    app = load(fullfile(path,file),'app');
    app =app.app;
end
