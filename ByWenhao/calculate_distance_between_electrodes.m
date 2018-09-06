function[distances] = calculate_distance_between_electrodes(anode_edges,cathode_edges)
% function[distances] = calculate_distance_between_electrodes(anode_edges,cathode_edges)
% This function calculates the distances between anodes and cathodes based
% on the positions of anode and cathode edges

% only  the distances in Y(vertical) direction is used
distances = zeros(29,1);

for i = 1:15
    distances(i) = abs(anode_edges(i)-cathode_edges(i));
end

for j = 1:14
    distances(j+15) = abs(anode_edges(j+1) - cathode_edges(j));
end