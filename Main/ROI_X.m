function[ROI_anode, ROI_cathode,start_column_of_anode] = ROI_X(img,threshold,anode_length)
% [ROI_anode, ROI_cathode,division_mark] = ROI_X(img,threshold, anode_length)
% This function extracts the anode and cathode regions and returns the
% column which is used to divide anode from cathode

% anode region: from right to left, extract the first column with mean 
% grayscale greater than the threshold and then extend 'anode_length'to the left

% cathode:first column to the 'start_column_of_anode'

% calculate the column-wise mean grayscale of the image
mean_gray_col = mean(img,1);

% from right to left, find the first column with grayscale greater than 'threshold'
% as the 'start_column_of_anode'

[row,col] = size(img);
for i = 1:col
    if mean_gray_col(col-i+1) >=threshold
        start_column_of_anode = col-i+1-anode_length;
        break
    end
end

% define the cathode region as the region from the first column to the 'start_column_of_anode'
ROI_cathode = img(:,1:start_column_of_anode);

% define the anode region as the region from the 'start_column_of_anode' to
% 'start_column_of_anode' +250
ROI_anode = img(:,start_column_of_anode: start_column_of_anode + 250);

end