function [table] = CreateTable(app,status)
%CREATETABLE Summary of this function goes here
%   Detailed explanation goes here

if status == "Start"
    app.TableInputFolder.ColumnName = {};
end
if status =="Load"
app.TableInputFolder.ColumnName = {'Name', 'Picture Count'};
app.TableInputFolder.ColumnWidth = {'auto', 100};
table=app.FolderSelection.InputFolders.Selected_Values';
%newCol = [];
%table = [table (app.FolderSelection.InputFolders.Selcted_Values)'];
for i=1:length(app.FolderSelection.InputFolders.Selected_Values)
    table{i,2} = length(app.FolderSelection.InputFolders.Sub_Path_Dirs.(app.FolderSelection.InputFolders.Selected_Values{1,i}));  
end
end

