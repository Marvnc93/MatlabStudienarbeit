function out = GetQualityPoints(Img,detectionFilterSize,quality)

points = detectHarrisFeatures(Img,'Filtersize',detectionFilterSize,'MinQuality', quality);
StrongPoints = points.selectStrongest(50).Location;
if numel(StrongPoints)==0
    out =[];
else
StrongPoints(:,3) = kmeans(StrongPoints,length(StrongPoints));
result=[];
tempx=[];
tempy=[];
for i=1:15
    for j = 1:length(StrongPoints)
        if StrongPoints(j,3)==i
            tempx = [tempx;StrongPoints(j,1)];
            tempy = [tempy;StrongPoints(j,2)];
        end
    end
    meanx = mean(tempx);
    meany = mean(tempy);
    result = [result; meanx,meany];
    tempx =[];
    tempy=[];
end
out=result;
end
% fig = figure;
% imshow(Img);
% hold on;
% %plot(StrongPoints(:,1),StrongPoints(:,2),'gx');
% plot(result(:,1),result(:,2),'gx');

end

