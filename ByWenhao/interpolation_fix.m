function[output_position] = interpolation_fix(edges_position)
% function[output_position] = interpolation_fix(edges_position)
% this function fixes the problem in recognizing the cathodes of battery
% cell 5, in some cases, the first cathode on the top is in the lower 
% position than the second or third cathode, which result in a wrong
% cathode recognition, to fix this problem, we manually adjust the position
% of the first cathode(also the longest cathode in the image).

%the detail of this problem is described in the Document.ppt.

mean_x = mean(edges_position(:,1));
edges_position = sortrows(edges_position,2);

for i = 1:5

    if abs(edges_position(i,1) - mean_x)>=100 & edges_position(i,2)>=min(edges_position(1:5,2))
        edges_position(i,2) = min(edges_position(1:5,2))-1;
    end
end
edges_position = sortrows(edges_position,2);

edges_position = sortrows(edges_position,2);


output_position = edges_position;
end