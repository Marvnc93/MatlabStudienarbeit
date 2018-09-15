function CalcDistance(CathodePoints,AnodePoints,Type)
%CALCDISTANCE Summary of this function goes here
%   Detailed explanation goes here
if exist('app','var') ==0
    app = load('D:\Studienarbeit\ProgrammFolder\apptest_PointsX.mat');
    app =app.app;
end
app.Distances.(Type) =[];

end

