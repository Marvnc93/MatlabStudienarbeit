function[distances_narrow, distances_broad, overlapping_rate] = edge_extraction_from_Y(Y_img)
% [distances_narrow, distances_broad, overlapping_rate] = edge_extraction_from_Y(Y_img)
% This function extractes the electrodes from Y-direction images,and returns 
% the distances on the broad and narrow side of the battery cell as well
% as the overlapping rate of the battery cell

% In this function, the distance on the broad side of the battery cell are in 
% the upper part of the Y-direction images,the distance on the narrow side of 
% the battery cell are in the lower part of the Y-direction images


for j = 1:size(Y_img,1)
    
    % load Y-direction images
    I = imread(Y_img(j,:));
    
    % extract the ROIs of anode and cathode in both top and bottom parts of
    % the image
    [ROI_anode_top,ROI_cathode_top,ROI_anode_bottom,ROI_cathode_bottom,anode_up_mark, cathode_up_mark, anode_down_mark, cathode_down_mark] = ROI_Y(I,20,100,100);
    
    % apply morphology closeing to all the ROIs, to fill up tiny holes
    % in the image, a 7*3 structural element is used for this operation
    SE = [1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1];
    ROI_anode_top = imclose(ROI_anode_top,SE);
    ROI_cathode_top = imclose(ROI_cathode_top,SE);
    ROI_anode_bottom = imclose(ROI_anode_bottom,SE);
    ROI_cathode_bottom = imclose(ROI_cathode_bottom,SE);
    
    %% top part of the Y-direction image
    
    % apply Harris method with filtersize 5 to extract the electrode edges
    points_anode_top = detectHarrisFeatures(ROI_anode_top,'FilterSize',5);
    
    % extract the positions of the strongest 25 corner points
    points_anode_top = points_anode_top.selectStrongest(25).Location;
    
    % remove the fake edges in the image
    points_anode_top = remove_fake_edges_Y(ROI_anode_top,points_anode_top,0,20);
    
    % same operations for the cathode
    points_cathode_top = detectHarrisFeatures(ROI_cathode_top,'FilterSize',5);
    points_cathode_top = points_cathode_top.selectStrongest(25).Location;
    points_cathode_top = remove_fake_edges_Y(ROI_cathode_top,points_cathode_top,0,20);
    
    % fit the curve through cubic interpolation, take 15 points equidistantly
    % as the electrode edge potins
    anode_top_interpol_x = linspace(min(points_anode_top(:,1)),max(points_anode_top(:,1)),15);
    anode_top_interpol_y  = interp1(points_anode_top(:,1),points_anode_top(:,2),anode_top_interpol_x, 'cubic');
    
    cathode_top_interpol_x = linspace(min(points_cathode_top(:,1)),max(points_cathode_top(:,1)),15);
    cathode_top_interpol_y = interp1(points_cathode_top(:,1),points_cathode_top(:,2),cathode_top_interpol_x, 'cubic');
    
    % transform the coordinates in the anode and cathode regions into the
    % coordinates in the orinigal image
    anode_top_interpol_y = anode_top_interpol_y + anode_up_mark;
    cathode_top_interpol_y = cathode_top_interpol_y + cathode_up_mark;
  
    %% bottom part of the Y-direction image
    
    % apply Harris method with filtersize 5 to extract the electrode edges
    points_anode_bottom = detectHarrisFeatures(ROI_anode_bottom,'FilterSize',5);
    
    % extract the positions of the strongest 25 corner points
    points_anode_bottom = points_anode_bottom.selectStrongest(25).Location;
    
    % remove the fake edges in the image
    points_anode_bottom = remove_fake_edges_Y(ROI_anode_bottom,points_anode_bottom,1,20);
    
    % same operations for the cathode
    points_cathode_down = detectHarrisFeatures(ROI_cathode_bottom,'FilterSize',5);
    points_cathode_down = points_cathode_down.selectStrongest(25).Location;
    points_cathode_down = remove_fake_edges_Y(ROI_cathode_bottom,points_cathode_down,1,20);     
    
    anode_bottom_interpol_x = linspace(min(points_anode_bottom(:,1)),max(points_anode_bottom(:,1)),15);
    anode_bottom_interpol_y =interp1(points_anode_bottom(:,1),points_anode_bottom(:,2),anode_bottom_interpol_x, 'cubic'); 
     
    cathode_bottom_interpol_x = linspace(min(points_cathode_down(:,1)),max(points_cathode_down(:,1)),15);
    cathode_bottom_interpol_y = interp1(points_cathode_down(:,1),points_cathode_down(:,2),cathode_bottom_interpol_x, 'cubic');

    anode_bottom_interpol_y = anode_bottom_interpol_y + anode_down_mark;
    cathode_bottom_interpol_y = cathode_bottom_interpol_y + cathode_down_mark;
    
    %---------------------------DEBUG--------------------------------------
%         figure,imshow(I), hold on,
%         plot(anode_top_interpol_x,anode_top_interpol_y,'g+')
%         plot(anode_bottom_interpol_x,anode_bottom_interpol_y,'b+')
%         plot(cathode_top_interpol_x,cathode_top_interpol_y,'r+')
%         plot(cathode_bottom_interpol_x,cathode_bottom_interpol_y,'y+')
    %---------------------------DEBUG--------------------------------------
    
    %% calculate the distances between electrodes
    
    % because the first electrodes of X-direction images
    % are the last electrodes of Y-direction images in the 'distances matrix',
    % in order to be consistent with the distances extracted from X-images,
    % the extracted edge positions are flipped, 
    
    anode_top_interpol_y = fliplr(anode_top_interpol_y);
    cathode_top_interpol_y = fliplr(cathode_top_interpol_y);
    anode_bottom_interpol_y = fliplr(anode_bottom_interpol_y);
    cathode_bottom_interpol_y = fliplr(cathode_bottom_interpol_y);
    
    distances_broad(:,j) = calculate_distance_between_electrodes(anode_top_interpol_y,cathode_top_interpol_y);
    distances_narrow(:,j) = calculate_distance_between_electrodes(anode_bottom_interpol_y,cathode_bottom_interpol_y);
    
    
end


end
