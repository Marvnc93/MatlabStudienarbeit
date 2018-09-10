function[output_position] = remove_fake_edges_Y(img,edge_position,electrode_location,threshold)
% [output_position] = remove_fake_edges_Y(img,edge_position,anode_direction,threshold)
% This function removes fake edges in the Y-direction images, inputs are
% the positions of the edges
% the location of electrode( 0: electrodes in the top part; 1:electrodes in the bottom part)
% same as the fake edge removal for X-direction images, this function also
% examines the neighbor regions of the electrode edge points

fake_index = ones(size(edge_position,1),1);

for i = 1:size(edge_position,1)
    
    % extract the nearby 40*10 region of each electrode edge points
    % the start and end nearby regions should not exceed the image
    % boundaries
    position_x =  [max(edge_position(i,1)-5,1),min(edge_position(i,1)+5,size(img,2))];
    position_y = [max(edge_position(i,2)-20,1),min(edge_position(i,2)+20,size(img,1))];
    
    % divide the nearby regions into two part for edge removal
    img_divided_top = img(max(edge_position(i,2)-20,1):edge_position(i,2),position_x(:,1):position_x(:,2));
    img_divided_bottom = img(edge_position(i,2):min(edge_position(i,2)+20,size(img,1)),position_x(:,1):position_x(:,2));
    
    % calculate the mean grayscale of the two divided nearby regions
    mean_sperate = zeros(2,1);
    mean_sperate(1) = mean(mean(img_divided_top,2));
    mean_sperate(2) = mean(mean(img_divided_bottom,2));
    
    % two cases for fake edge removal in Y-images, one case for electrodes
    % on the top and one case for the electrodes on the bottom
    
    switch electrode_location
        case 0
            if mean_sperate(1)<mean_sperate(2) & (mean_sperate(2) - mean_sperate(1))>=threshold
                fake_index(i) = 0;
            end
        case 1
            if mean_sperate(1)>mean_sperate(2) & (mean_sperate(1) - mean_sperate(2))>=threshold
                fake_index(i) = 0;
            end
    end
    
end

edge_position(find(fake_index==1),:) =[];
output_position = edge_position;

end