function[distances_narrow, distances_broad] = edge_extraction_from_X(X_img)
% [distances_narrow, distances_broad,overlapping] = edge_extraction_from_X(Path_of_X_img)
% This function returns the 29 distances between anodes and cathodes on
% both narrow side and broad side of the battery cells, and the overlapping
% rate of the battery cell.

% The image file path are saved in rows of the input variable. First half
% are the X-direction images on the narrow side, the second half are the
% X-direction images on the broad side.
% e.g:

% Img_path =[
%    'E:\X-ray images\6_Slices\Slices\X\zelle6_slices_X_0332.bmp'
%    'E:\X-ray images\6_Slices\Slices\X\zelle6_slices_X_0333.bmp'
%    'E:\X-ray images\6_Slices\Slices\X\zelle6_slices_X_0334.bmp'
%    'E:\X-ray images\6_Slices\Slices\X\zelle6_slices_X_1134.bmp'
%    'E:\X-ray images\6_Slices\Slices\X\zelle6_slices_X_1135.bmp'
%    'E:\X-ray images\6_Slices\Slices\X\zelle6_slices_X_1136.bmp'
%    ]
%

%%
%-------------------narrow side of battery cells---------------------------
for i = 1:size(X_img,1)/2
    % load image file
    I = imread(X_img(i,:));
    % image enhancement
    % extract the battery cell package value
    [row,col] = size(I);
    package_grayvalue = max(max(I(:,col-50:col)));
        %figure,imshow(I)
    % apply the battery cell package value for the grayscale stretching
    I = imadjust(I, [double(package_grayvalue)/255,1],[]);
        %figure,imshow(I)
    % Region of interest extraction
    [ROI_anode,ROI_cathode,division_column_anode] = ROI_X(I,10,70);
        %figure('Name','ROI anode','NumberTitle','off'),imshow(ROI_anode)
        %figure('Name','ROI cathode','NumberTitle','off'),imshow(ROI_cathode)
    %% anode edge extraction
    % apply Harris method with filtersize 5 to extract the electrode edges
    points_anode = detectHarrisFeatures(ROI_anode,'FilterSize', 5);
    
    % select the strongest 25 points
    points_anode = points_anode.selectStrongest(25).Location;
    
    % fake electrode edge removal
    points_anode_no_outlier  = remove_fake_edges_X(ROI_anode,points_anode,30);
    
    % fit the curve through cubic interpolation, take 15 points equidistantly 
    % as the electrode edge potins
    anode_interpol_y = linspace(min(points_anode_no_outlier(:,2)),max(points_anode_no_outlier(:,2)),15);
    anode_interpol_x = interp1(points_anode_no_outlier(:,2),points_anode_no_outlier(:,1),anode_interpol_y, 'cubic');
    
    %% Cathode edges extraction
    % morphology closing to fill tiny holes in the cathode region
    
    % 3*3 square structural element
    SE = strel('square', 3);
    
    % apply morphology closing to the cathode region
    ROI_cathode = imclose(ROI_cathode,SE);
    
    %% anode edge extraction
    % apply Harris method with filtersize 5 to extract the electrode edges
    points_cathode = detectHarrisFeatures(ROI_cathode, 'FilterSize', 5);
    
    % select the strongest 25 edges
    points_cathode = points_cathode.selectStrongest(25).Location;
    
    % fake electrode edge removal
    points_cathode_no_outlier  = remove_fake_edges_X(ROI_cathode,points_cathode,30);
    
    % fix the problem of interpolation
    points_cathode_no_outlier = interpolation_fix(points_cathode_no_outlier);
    
    % fit the curve through cubic interpolation, take 15 points equidistantly 
    % as the electrode edge potins
    cathode_interpol_y = linspace(min(points_cathode_no_outlier(:,2)),max(points_cathode_no_outlier(:,2)),15);
    cathode_interpol_x = interp1(points_cathode_no_outlier(:,2),points_cathode_no_outlier(:,1),cathode_interpol_y, 'cubic');
    
    %%
    % transform the coordinates in the anode and cathode regions into the 
    % coordinates in the orinigal image
    anode_interpol_x = anode_interpol_x + division_column_anode;
    
    % calculate the distances between anodes and cathodes
    distances_narrow(:,i) = calculate_distance_between_electrodes(anode_interpol_x,cathode_interpol_x);
    
    %---------------------------DEBUG--------------------------------------
%         figure, imshow(ROI_cathode), hold on, plot(points_cathode_no_outlier(:,1),points_cathode_no_outlier(:,2),'r+')
%         figure,imshow(ROI_anode), hold on,plot(points_anode_no_outlier(:,1),points_anode_no_outlier(:,2),'r+')
%         figure, imshow(I), hold on, plot(anode_interpol_x,anode_interpol_y,'r+')
%         hold on, plot(cathode_interpol_x,cathode_interpol_y,'g+')
    
    %---------------------------DEBUG--------------------------------------
    
end


%%
% ----------------------broad side of battery cells------------------------
for j = 1:size(X_img,1)/2

    % loading image file
    I = imread(X_img(j+size(X_img,1)/2,:));
    
    % image enhancement
    % extract the battery cell package value
    [row,col] = size(I);
    package_grayvalue = max(max(I(:,col-50:col)));
    
    % apply the battery cell package value for the grayscale stretching
    I = imadjust(I, [double(package_grayvalue)/255,1],[]);
    
     % Region of interest extraction
    [ROI_anode,ROI_cathode,division_column_cathode] = ROI_X(I,10,70);
    
    % apply Harris method with filtersize 5 to extract the electrode edges
    points_anode = detectHarrisFeatures(ROI_anode,'FilterSize',5);
    
    % select the strongest 25 points
    points_anode = points_anode.selectStrongest(25).Location;
    
    % fake electrode edge removal
    points_anode_no_outlier  = remove_fake_edges_X(ROI_anode,points_anode,30);
       
    % fit the curve through cubic interpolation, take 15 points equidistantly 
    % as the electrode edge potins
    anode_interpol_y = linspace(min(points_anode_no_outlier(:,2)),max(points_anode_no_outlier(:,2)),15);
    anode_interpol_x = interp1(points_anode_no_outlier(:,2),points_anode_no_outlier(:,1),anode_interpol_y, 'cubic');
    
   %% Cathode edges extraction
   
   % morphology closing to fill tiny holes in the cathode region
    
    % 3*3 square structural element
    SE = strel('square', 3);
    
    % apply morphology closing to the cathode region
    ROI_cathode = imclose(ROI_cathode,SE);
    
    % apply Harris method with filtersize 5 to extract the electrode edges
    points_cathode = detectHarrisFeatures(ROI_cathode,'FilterSize',5);
    
    % select the strongest 25 edges
    points_cathode = points_cathode.selectStrongest(25).Location;
    
    % fake edge removal
    points_cathode_no_outlier  = remove_fake_edges_X(ROI_cathode,points_cathode,30);
    points_cathode_no_outlier = interpolation_fix(points_cathode_no_outlier);
   
    % fit the curve through cubic interpolation, take 15 points equidistantly
    % as the electrode edge potins
    cathode_interpol_y = linspace(min(points_cathode_no_outlier(:,2)),max(points_cathode_no_outlier(:,2)),15);
    cathode_interpol_x = interp1(points_cathode_no_outlier(:,2),points_cathode_no_outlier(:,1),cathode_interpol_y, 'cubic');
    
    %%
    % transform the coordinates in the anode and cathode regions into the
    % coordinates in the orinigal image
    anode_interpol_x = anode_interpol_x + division_column_cathode;
    
    % calculate the distances between anodes and cathodes
    distances_broad(:,j) = calculate_distance_between_electrodes(anode_interpol_x,cathode_interpol_x);
    
    %-----------------------------DEBUG------------------------------------
%         figure, subplot(1,2,1),imshow(ROI_cathode), hold on, plot(points_cathode_no_outlier(:,1),points_cathode_no_outlier(:,2),'r+')
%         figure, imshow(ROI_anode), hold on,plot(points_anode_no_outlier(:,1),points_anode_no_outlier(:,2),'r+')
%         figure, imshow(I), hold on, plot(anode_interpol_x,anode_interpol_y,'rx')
%         hold on, plot(cathode_interpol_x,cathode_interpol_y,'gx')
    %-----------------------------DEBUG------------------------------------
    
end

end