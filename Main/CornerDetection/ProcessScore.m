function [xa,xc,ya,yc] = ProcessScore(rOI,column)
%PROCESSSCORE Summary of this function goes here
%   Detailed explanation goes here
struc = struct;
struc.xaa=[];
struc.xca=[];
struc.yaa=[];
struc.yca=[];
for i=1:size(rOI,1)
    if rOI{i,3}=="Y_ROI" && rOI{i,4}=="Cathode"
        struc.yca = [struc.yca;rOI{i,[5 column]}];
    elseif rOI{i,3}=="Y_ROI" && rOI{i,4}=="Anode"
        struc.yaa = [struc.yaa;rOI{i,[5 column]}];
    elseif rOI{i,3}=="X_ROI" && rOI{i,4}=="Cathode"
        struc.xca = [struc.xca;rOI{i,[5 column]}];
    elseif rOI{i,3}=="X_ROI" && rOI{i,4}=="Anode"
        struc.xaa = [struc.xaa;rOI{i,[5 column]}];
    end
end
fields =fieldnames(struc);
for i=1:size(fields,1)
    %calculate the Quotient from pointsFoundAdj / userpoints
    struc.(fields{i})(:,3) =struc.(fields{i})(:,2)./struc.(fields{i})(:,1);
    struc.(fields{i})(1,4)= mean(struc.(fields{i})(:,3),1);
end
xa=struc.xaa(1,4);
xc=struc.xca(1,4);
ya=struc.yaa(1,4);
yc =struc.yca(1,4);



