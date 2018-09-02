function [] = ListFolders(app)
%LISTFOLDER Summary of this function goes here
%   Detailed explanation goes here
Directory = dir(app.FolderSelection.Input_Path);
Directory=Directory(~ismember({Directory.name},{'.','..'}));
Folder_Counter=1;
CharsThatDestroyStructCreation = {' ','''','%','(',')'};
app.FolderSelection.InputFolders.Main_Path_Dir = Directory;
%Folder_Names(strcmp(Folder_Names,'..'))=[];
Folder_Names = {app.FolderSelection.InputFolders.Main_Path_Dir.name};
app.FolderSelection.InputFolders.Sub_Path_Dirs = struct;

Folder_Names_Filtered ={};
 for i=1:length(Folder_Names)
     if contains(Folder_Names{1,i},'.')==false
         if contains(Folder_Names{1,i},CharsThatDestroyStructCreation)==true
             Folder_Names{1,i} = erase(Folder_Names{1,i},CharsThatDestroyStructCreation);
         end
         Folder_Names_Filtered{1,Folder_Counter}= Folder_Names{1,i};
         Folder_Counter =Folder_Counter+1;
     end
 end
 if(length(Folder_Names)>length(Folder_Names_Filtered))
     warndlg('The Input folder contains data or folders with a dot in the name. Please be aware that these are not processable','Warning');
 end
 app.FolderListBox.Items = Folder_Names_Filtered;
 
for i=1:length(Folder_Names_Filtered)
    app.FolderSelection.InputFolders.Sub_Path_Dirs.(Folder_Names_Filtered{1,i}) = struct;
    Current_Struct = app.FolderSelection.InputFolders.Sub_Path_Dirs.(Folder_Names_Filtered{1,i});
    Current_Struct = dir(fullfile([app.FolderSelection.Input_Path, filesep, Folder_Names_Filtered{1,i}], '*.bmp'));
    %app.FolderSelection.InputFolders.Sub_Path_Dirs.(Folder_Names_Filtered{1,i}) = Current_Struct(~ismember({Current_Struct.name},{'.','..'}));
    app.FolderSelection.InputFolders.Sub_Path_Dirs.(Folder_Names_Filtered{1,i}) = Current_Struct();
end

end

