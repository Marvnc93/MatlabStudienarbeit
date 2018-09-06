%function[overlapping_rate,num_of_uncovered_electrode] = overlapping_rate_evaluation(distances_narrow,distances_broad, electrode_length, electrode_width, resolution)
function[overlapping_rate] = overlapping_rate_evaluation(distances_narrow,distances_broad, electrode_length, electrode_width, resolution)
% [overlapping_rate,num_of_uncovered_electrode] = overlapping_rate_evaluation(distances_narrow,distances_broad)
% This function calculates the overlapping rate based on the distances
% between anode and cathode
%num_of_uncovered_electrode = 0;

% calculate the uncovered area of each cathode
% in this case, resolution: 25pixel = 1 um
% the gap length between anode and cathode on both broad and narrow side
% should be no greater than 5 mm
uncovered_area_broad = zeros(size(distances_broad));
uncovered_area_narrow = zeros(size(distances_narrow));

% calculate the non-overlapped area on the broad side
for i = 1:size(distances_broad,1)
    for j = 1:size(distances_broad,2)
        % resolution/1000 - 5 = the exceeded length
        exceeded_lenght = distances_broad(i,j)*resolution/1000-5;
            %exceeded_lenght = distances_broad(i,j)/(resolution*1000) -5;
        %dis=200px & 25 px = 1um
        if exceeded_lenght>0
            %num_of_uncovered_electrode = num_of_uncovered_electrode+1;
            uncovered_area_broad(i,j) = (distances_broad(i,j)*resolution/1000 - 5)*electrode_width;
                        %uncovered_area_broad(i,j) = (distances_broad(i,j)*resolution/1000 - 5)*electrode_width;
        end
    end
end

% calculate the non-overlapped area on the narrow side
for i = 1:size(distances_narrow,1)
    for j = 1:size(distances_narrow,2)
        exceeded_lenght = distances_narrow(i,j)*resolution/1000-5;
            %exceeded_lenght = distances_narrow(i,j)/(resolution*1000) -2.5;
        if exceeded_lenght>0
            %num_of_uncovered_electrode = num_of_uncovered_electrode + 1;
            uncovered_area_narrow(i,j) = (distances_narrow(i,j)*resolution/1000 - 5)*electrode_length;
        end
    end
end

% calculate the overlapping rate
uncoverage_rate_broad = sum(uncovered_area_broad,1)/electrode_length/electrode_width/29;
uncoverage_rate_narrow = sum(uncovered_area_narrow,1)/electrode_length/electrode_width/29;
overlapping_rate = ones(size(uncoverage_rate_broad));
overlapping_rate = overlapping_rate - uncoverage_rate_broad - uncoverage_rate_narrow;
end