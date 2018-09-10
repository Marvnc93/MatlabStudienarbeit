function [] = FolderPicker(app,type)
%FILEPICKER Summary of this function goes here
%   Detailed explanation goes here
if type == "input"
    app.UIFigure.Visible = 'off';
    app.FolderSelection.Input_Path = uigetdir;
    app.InputDataFolderEditField.Value = app.FolderSelection.Input_Path;
    ListFolders(app);
    
elseif type =="output"
    app.UIFigure.Visible = 'off';
    app.FolderSelection.Output_Path = uigetdir;
    app.OutputDataFolderEditField.Value = app.FolderSelection.Output_Path;
    
elseif type=="programm"
    app.UIFigure.Visible = 'off';
    app.FolderSelection.Programm_Path = uigetdir;
    app.ProgrammDataFolderEdit.Value = app.FolderSelection.Programm_Path;
end
app.UIFigure.Visible = 'on';

%assignin('base','FolderSelection',FolderSelection);
end

