function[image_path_X,image_path_Y,image_path_Z] = images_to_process(main_path,num_of_samples)
% [image_path_X,image_path_Y,image_path_Z] = images_to_process(main_path,num_of_samples,corner_radius)
% the x ray images of electrodes should not be the images which are in the rounded corner zone

%---------------- images in X direction to process -----------------------
file_names_X = dir([main_path,'\X\', '*.bmp']);
% for X-direction-images, the rounded corners are at the place where
% electrodes have maximal extensions. To avoid corner zone,images with electrode extension
% length of 680 pixels are selected. 680 pixel on the one hand ensures
% sufficient space to measure the distances between electrodes and on the
% other hand avoids rounded corner zone.

left_index = 0;
right_index = 0;
i = 0;
break_flag = true;
min_electrode_length = 680;
%min_electrode_length = 600;
% right_index is the index for choosing the X-images on the broad side of the
% electrode
while break_flag == true
    filename = file_names_X(length(file_names_X)-i).name;
    filepath = [main_path,'\X\', filename];
    I = imread(filepath);
    mean_gray = mean(I);
    anode_end_column = 0;
    for j = 1:length(mean_gray)
        if mean_gray(length(mean_gray)-j+1) > 20
            anode_end_column = length(mean_gray)-j+1;
            break
        end
        
    end
    
    if anode_end_column > min_electrode_length
        break_flag = false;
        right_index = length(file_names_X)-i;
    end
    i = i+10;
end
   
% left_index is the index for choosing the X-images on the narrow side of the
% electrode
left_index = 0;
k = 1;
break_flag = true;

while break_flag == true
    filename = file_names_X(k).name;
    filepath = [main_path,'\X\', filename];
    I = imread(filepath);
    mean_gray = mean(I,1);
    anode_end_column = 0;
    
    for j = 1:length(mean_gray)
        if mean_gray(length(mean_gray)-j+1) > 30
            anode_end_column = length(mean_gray)-j+1;
            break
        end
    end
    if anode_end_column > min_electrode_length
        break_flag = false;
        left_index = k;
    end
    k = k+10;
end

image_path_X = [];

%for broad side

for m = 1:num_of_samples
    filename_right = file_names_X(right_index -m).name;
    filepath_right = [main_path,'\X\', filename_right];
    image_path_X = [image_path_X;filepath_right];
end

%for broad side

for m = 1:num_of_samples
    filename_left = file_names_X(left_index + m).name;
    filepath_left = [main_path,'\X\', filename_left];
    image_path_X = [image_path_X;filepath_left];
end

%---------------- images in Y direction to process -----------------------%
% Images in the Y-direction with complete anodes in both top and bottom part are selected.

% main_dir = maindir;
file_names_Y = dir([main_path,'\Y\', '*.bmp']);
i = 1;
Y_index_up = 0;
Y_index_down = 0;
Y_img_start = 1;
break_flag = false;
while break_flag == false
    filename = file_names_Y(i).name;
    filepath = [main_path,'\Y\', filename];
    I = imread(filepath);
    mean_gray = mean(I,2);
    for m = 1:length(mean_gray)
        if mean_gray(m)>10
            Y_index_up = m;
            break
        end
    end
    
    for n = 1:length(mean_gray)
        if mean_gray(length(mean_gray) -n+1)>10
            Y_index_down = length(mean_gray) -n+1;
            break
        end
    end

    
    if (Y_index_up) > 50 & (Y_index_down< length(mean_gray)-50)
        break_flag = true;
        Y_img_start = i;
    end
    i = i+10;
end

image_path_Y = [];
for n = 1:num_of_samples
    filename_Y = file_names_Y(Y_img_start +n).name;
    filepath_Y = [main_path,'\Y\', filename_Y];
    image_path_Y = [image_path_Y;filepath_Y];
end


%_____________________Z_img________________________________________________
file_names_Z = dir([main_path,'\Z\', '*.bmp']);
image_path_Z = [];
for k = 1:(length(file_names_Z)-200)/10
    filename_Z = file_names_Z(round(k*10)+100).name;
    filepath_Z = [main_path,'\Z\', filename_Z];
    image_path_Z = [image_path_Z;filepath_Z];
end


end
