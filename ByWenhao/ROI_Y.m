function[ROI_anode_top,ROI_cathode_top,ROI_anode_bottom,ROI_cathode_bottom,mark_top_anode,mark_top_cathode,mark_bottom_anode,mark_bottom_cathode] = ROI_Y(img, threshold, anode_length,cathode_length)
% [ROI_anode_up,ROI_cathode_up,ROI_anode_down,ROI_cathode_down,mark_up_anode,mark_up_cathode,mark_down_anode,mark_down_cathode] = ROI_Y(img)
% This function extract the 4 anode and cathode regions in the Y-direction
% image

% This function searches the first row with mean grayscale value greater
% than the threshold, and set the row as the start row of the anode

% calculate the row-wise mean grayscale value
mean_gray = mean(img,2);

% from top to bottom, search the first row with mean grayscale value greater
% than the threshold, and mark the row as the start row of anode on the top. 

for i = 1:size(img,1)
    if mean_gray(i)>= threshold
        mark_top = i;
        ROI_anode_top = img(1:mark_top+anode_length,:);
        break
    end
end

% from bottom to top, search the first row with mean grayscale value greater
% than the threshold, and mark the row as the start row of the anode in the bottom part. 
for j = 1:size(img,1)
    if mean_gray(size(img,1)-j)>=threshold
        mark_bottom = size(img,1)-j;
        ROI_anode_bottom = img(mark_bottom-anode_length:end,:);
        break
    end
end

% from top to bottom, search the first row with mean grayscale value greater than 0.9* overall maxmal
% grayscale value as the start row of the cathode on the top.
for i = 1:size(img,1)
    if mean_gray(i)>= 0.9*max(mean_gray)
        cathode_top = i;
        break
    end
end

% from bottom to top, search the first row with mean grayscale value greater than 0.9* overall maxmal
% grayscale value as the start row of the cathode on the bottom.
for j = 1:size(img,1)
    if mean_gray(size(img,1)-j)>=0.9*max(mean_gray)
        cathode_bottom = size(img,1)-j;
        break
    end
end

% seperate the cathodes on the top and bottom
seperate_cathode = 0.5*(cathode_top+cathode_bottom);

% define the cathode regions
ROI_cathode_top = img(mark_top+cathode_length:seperate_cathode,:);
ROI_cathode_bottom = img(seperate_cathode:mark_bottom-cathode_length,:);

% figure,subplot(1,4,1),imshow(ROI_anode_up)
% subplot(1,4,2),imshow(ROI_cathode_up)
% subplot(1,4,3),imshow(ROI_cathode_down)
% subplot(1,4,4),imshow(ROI_anode_down)

% return the row number where the anodes and cathodes start and end 
mark_top_anode = 1;
mark_top_cathode = mark_top+cathode_length;
mark_bottom_anode = mark_bottom-cathode_length;
mark_bottom_cathode = seperate_cathode;



end
