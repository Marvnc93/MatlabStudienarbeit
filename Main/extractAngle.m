function[img_angle] = extractAngle(Z_img_path)
% [img_angle] = image_acquisition_angle_extraction(Z_img_path)
% This function applies Hough transformation to extract the image
% acquisition angle.

slope_Z = [];

for i = 1:size(Z_img_path,1)
    % load Z-direction images
    filepath = Z_img_path(i,:);
    I = imread(filepath);
    
    % extract the electrode edges in the Z-direction image
    edges = edge(I,'canny',0.25);
    
    % apply Hough transformation for straight line detection
    [H,T,R] = hough(edges,'Theta',30:0.5:60);
    
    % select 2 straight lines which have the most points on these lines
    P = houghpeaks(H,2);
    lines = houghlines(edges, T,R,P);
    lines_P1 = [];
    lines_P2 = [];
    
    % extract the start and end points of the lines
    for k = 1:length(lines)
        lines_P1 = [lines_P1;lines(k).point1];
        lines_P2 = [lines_P2;lines(k).point2];
    end
    lines_x = [lines_P1(:,1),lines_P2(:,1)];
    lines_y = [lines_P1(:,2),lines_P2(:,2)];
    
    % calculate the slope of the line and transform it into degree
    
    slope_temp = [];
    
    for l = size(lines_x,1)
        if length(lines_x)>0
            slope_temp = [slope_temp,(lines_P1(l,2)-lines_P2(l,2))/(lines_P1(l,1)-lines_P2(l,1))];
        end
    end
    
    % calculate the average slope extracted from Z-images
    slope_average = mean(slope_temp);
    
    slope_Z = [slope_Z,slope_average];
end

% transform the slope into radian
img_angle = atan(mean(slope_Z))*180/pi;
end