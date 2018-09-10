%function [image_path_X,image_path_Y,image_path_Z] = images_to_process_new(main_path,num_of_samples)
function [] =images_to_process_new(app)
%function [] =images_to_process_new()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% [image_path_X,image_path_Y,image_path_Z] = images_to_process(main_path,num_of_samples,corner_radius)
% the x ray images of electrodes should not be the images which are in the rounded corner zone

%app=load("apptest.mat");
%Remove Files that were not selected in the table
unwantedDirs = rmfield(app.FolderSelection.InputFolders.Sub_Path_Dirs,app.FolderSelection.InputFolders.Selected_Values);
app.FolderSelection.InputFolders.Sub_Path_Dirs = rmfield(app.FolderSelection.InputFolders.Sub_Path_Dirs,fieldnames(unwantedDirs));

structs_to_iterate = fieldnames(app.FolderSelection.InputFolders.Sub_Path_Dirs);
%-----------Config--------------------------#
%--------X-----------------
min_electrode_length = app.ImageSelection.ImportSettings.xMinLength; %Standard 680
distance_from_middle = app.ImageSelection.ImportSettings.xDistToMiddle;  %Standard 50
%--------Y-----------------
min_lengh_of_electrodes = app.ImageSelection.ImportSettings.yMinLength;  %Standard 500
min_distance_to_edge = app.ImageSelection.ImportSettings.yDistToEdge;  %Standard 20
%--------Z-----------------
number_of_z_files = app.ImageSelection.ImportSettings.zAmount;  %Standard 30
%--------General-----------


%-------------------------------------------
%get_files = dir([main_path, '/*.bmp']);
for o=1:length(structs_to_iterate)

    get_files = app.FolderSelection.InputFolders.Sub_Path_Dirs.(structs_to_iterate{o})
    main_path = get_files.folder;
    all_files.files_X =[];
    all_files.files_Y =[];
    all_files.files_Z =[];
    all_files.files_X_out=[];
    all_files.files_X_out_narrow=[];
    all_files.files_X_out_broad=[];
    all_files.files_Y_out=[];
    all_files.files_Z_out=[];
    all_files.anode_length_X=[];
    for c=1:size(get_files,1)
        if strfind(get_files(c).name,'X') >0
            all_files.files_X =[all_files.files_X;fullfile(main_path,get_files(c).name)];
        end
        if strfind(get_files(c).name,'Y') >0
            all_files.files_Y =[all_files.files_Y;fullfile(main_path,get_files(c).name)];
        end
        if strfind(get_files(c).name,'Z') >0
            all_files.files_Z =[all_files.files_Z;fullfile(main_path,get_files(c).name)];
        end
    end

    %---------------- images in X direction to process -----------------------

    % for X-direction-images, the rounded corners are at the place where
    % electrodes have maximal extensions. To avoid corner zone,images with electrode extension
    % length of 680 pixels are selected. 680 pixel on the one hand ensures
    % sufficient space to measure the distances between electrodes and on the
    % other hand avoids rounded corner zone.

    %Hier werden alle files die sich in der X-Kategorie befinden durchiteriert
    %und wenn die electrode mindestens 680 pixel breit ist in files_x_out
    %geladen
    for i=1:size(all_files.files_X,1)
        %path= main_path+'/'+files_X(i)
        %path = fullfile(main_path,files_X(i))
        Img=imread(all_files.files_X(i,:));
        mean_gray_X=mean(Img);   
        for j = 1:length(mean_gray_X)
            if mean_gray_X(length(mean_gray_X)-j+1) > 20
                anode_end_column = length(mean_gray_X)-j+1;
                if anode_end_column > min_electrode_length
                    all_files.anode_length_X = [all_files.anode_length_X;anode_end_column];
                    all_files.files_X_out = [all_files.files_X_out; all_files.files_X(i,:)];

                end
                break
            end
        end   
    end
    %Einen schlauch um das mittlere Bild erstellen 
    [M,I] = max(all_files.anode_length_X);
    for i = 1:size(all_files.anode_length_X,1)
        if i<I-distance_from_middle
            all_files.files_X_out_narrow = [all_files.files_X_out_narrow; all_files.files_X_out(i,:)];
        end
        if i>I+distance_from_middle
            all_files.files_X_out_broad = [all_files.files_X_out_broad; all_files.files_X_out(i,:)];
        end

    end
    disp('Files X selected')
    %---------------- images in Y direction to process -----------------------%
    % Images in the Y-direction with complete anodes in both top and bottom part are selected.

    for i=1:size(all_files.files_Y,1)    
        Img=imread(all_files.files_Y(i,:));
        mean_gray_Y = mean(Img,2);
        index_Y_up = find(mean_gray_Y >10,1,'first');
        index_Y_down = find(mean_gray_Y >10,1,'last');
        if index_Y_up == index_Y_down
            break;
        end
        if isempty(index_Y_down) == 1 ||isempty(index_Y_up) == 1
            break;
        end
        if index_Y_up > min_distance_to_edge && length(mean_gray_Y)-index_Y_down >min_distance_to_edge && index_Y_down - index_Y_up > min_lengh_of_electrodes
             all_files.files_Y_out = [all_files.files_Y_out; all_files.files_Y(i,:)];  
        end
    end
    disp('Files Y selected')
    %-----------------------Z_img-----------------------------------------------

    for i = 1:number_of_z_files
        start = ceil(size(all_files.files_Z,1)/2-5*(number_of_z_files/2)-5);
        all_files.files_Z_out = [all_files.files_Z_out; all_files.files_Z(start + i*5,:)];
    end
    disp('Files Z selected')
    app.ImageSelection.(structs_to_iterate{o}).X_Narrow = all_files.files_X_out_narrow;
    app.ImageSelection.(structs_to_iterate{o}).X_Broad = all_files.files_X_out_broad;
    app.ImageSelection.(structs_to_iterate{o}).Y = all_files.files_Y_out;
    app.ImageSelection.(structs_to_iterate{o}).Z = all_files.files_Z_out;
end

end 

