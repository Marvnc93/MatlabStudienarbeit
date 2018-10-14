function index = GetCutoffIndex(smoothData,direction)
%GETCUTOFFINDEX Summary of this function goes here
%   Detailed explanation goes here

Med = median(smoothData);
len = numel(smoothData);
%For Narrow images
if direction=="backwards"
    i=len;
    while smoothData(i) >Med
        i=i-1;
    end
end
%For Broad images
if direction =="forwards"
    i=1;
    while smoothData(i) >Med
        i=i+1;
    end
end
    index =i;
    
    
    
    
