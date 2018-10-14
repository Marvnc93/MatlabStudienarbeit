function index = GetBestImageIndex(x,y,inMedian)
%GETBESTIMAGEINDEX Summary of this function goes here
%   Detailed explanation goes here
x =single(x);
filterRange = 15;
i = filterRange+1;
result = [];
while i<numel(x)-filterRange
lobf = abs(polyfit(x(i-filterRange:i+filterRange),y(i-filterRange:i+filterRange),1));
med = abs(inMedian-median(y(i-filterRange:i+filterRange)));

result(i-filterRange,:) = [med lobf(1) med*lobf(1)];
% if med>0.5
%     result(i-filterRange,2)=1;
% end
i =i+1;
end
[~,I] =min(result(:,3));
index = I+filterRange;
end

