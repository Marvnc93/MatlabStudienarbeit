function[output_position] = remove_fake_edges_X(img,edge_position,threshold)
% [output_position] = remove_fake_edges_X(img,edge_position,threshold)
% This function checks all the edges detected and removes the fake edges.
% By compare the mean grayscale of the regions on right and left side of the
% edge points, the fake edges can be removed
% mean grayscale on the left side of the edge points should be at least threshold larger
% thant the mean grayscale on the right side of the edge points.


% create index for fake edge removal
fake_index = ones(size(edge_position,1),1);


for i = 1:size(edge_position,1)
    
    % extract a 10*40 rectangle neighbor region of each edge points
    position_y = [max(edge_position(i,2)-5,1),min(edge_position(i,2)+5,size(img,1))];
    position_x =  [max(edge_position(i,1)-20,1),min(edge_position(i,1)+20,size(img,2))];
    
    % left region of the edge point
    img_divided_left = img(position_y(:,1):position_y(:,2),position_x(:,1):edge_position(i,1));
    
    % right region of the edge point
    img_divided_right = img(position_y(:,1):position_y(:,2),edge_position(i,1):position_x(:,2));
    
    % calculate the mean grayscale intensity of the left and the right
    % neighbor regions of the edge point
    mean_sperate = zeros(2,1);
    mean_sperate(1) = mean(mean(img_divided_left,1));
    mean_sperate(2) = mean(mean(img_divided_right,1));
    
    % The edge will be remained only if the mean grayscale on the left side is threshold greater than the right
    % side and the fake index of the edge point will be set to 0
    if mean_sperate(1)>mean_sperate(2) & (mean_sperate(1) - mean_sperate(2))>=threshold
        fake_index(i) = 0;
    end
    
end

edge_position(find(fake_index==1),:) =[];
output_position = edge_position;

% hold on ,plot(output_position(:,1),output_position(:,2),'r+')
end