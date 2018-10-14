if exist('app','var') ==0
    app = load('D:\Studienarbeit\ProgrammFolder\appcomplete.mat');
    app =app.app;
end
load('userdist.mat');
selectedValues = app.FolderSelection.InputFolders.Selected_Values;
%% Right (Narrow) Y
i=3;
j = 100;
nA=app.ImageSelection.(selectedValues{i}).Y_ROI.rightAnodeROI(j,:);
nC=app.ImageSelection.(selectedValues{i}).Y_ROI.rightCathodeROI(j,:);

 fig = figure;
% 
subplot(1,2,1)
imshow(nA{1})
[xa,ya]=getpts;
subplot(1,2,2)
imshow(nC{1});
[xc,yc]=getpts;
close all;

 angle = extractAngle(app.ImageSelection.(selectedValues{i}).Z)
% actual_distance_narrow_Y = distance_narrow_Y*cos((90+image_acquisition_angle)/180*pi);
% actual_distance_broad_Y = distance_broad_Y*sin((90+image_acquisition_angle)/180*pi);
% actual_distance_narrow_X = distance_narrow_X * sin((90+image_acquisition_angle)/180*pi);
% actual_distance_broad_X = distance_broad_X*cos((90+image_acquisition_angle)/180*pi);
pointsAnode = [xa,ya];
pointsCathode = [xc,yc];
pointsAnode=sortrows(pointsAnode,2);
pointsCathode = sortrows(pointsCathode,2);
pointsAnode(:,1)= pointsAnode(:,1)+single(app.ImageSelection.(selectedValues{i}).Y_ROI.rightAnodeROI{j,2});
pointsCathode(:,1)= pointsCathode(:,1)+single(app.ImageSelection.(selectedValues{i}).Y_ROI.rightCathodeROI{j,2});
distances = GetDistance(pointsCathode(:,1),pointsAnode(:,1)).* cos((90+angle)/180*pi);
userdist.Y.(selectedValues{i}).right = distances;
save('userdist.mat','userdist');
"end"


%% Left (Broad) Y

% i=3;
% j = 100;
% nA=app.ImageSelection.(selectedValues{i}).Y_ROI.leftAnodeROI(j,:);
% nC=app.ImageSelection.(selectedValues{i}).Y_ROI.leftCathodeROI(j,:);
% 
%  fig = figure;
% % 
% subplot(1,2,1)
% imshow(nA{1})
% [xa,ya]=getpts;
% subplot(1,2,2)
% imshow(nC{1});
% [xc,yc]=getpts;
% 
% 
%  angle = extractAngle(app.ImageSelection.(selectedValues{i}).Z)
% % actual_distance_narrow_Y = distance_narrow_Y*cos((90+image_acquisition_angle)/180*pi);
% % actual_distance_broad_Y = distance_broad_Y*sin((90+image_acquisition_angle)/180*pi);
% % actual_distance_narrow_X = distance_narrow_X * sin((90+image_acquisition_angle)/180*pi);
% % actual_distance_broad_X = distance_broad_X*cos((90+image_acquisition_angle)/180*pi);
% pointsAnode = [xa,ya];
% pointsCathode = [xc,yc];
% pointsAnode=sortrows(pointsAnode,2);
% pointsCathode = sortrows(pointsCathode,2);
% pointsAnode(:,1)= pointsAnode(:,1)+single(app.ImageSelection.(selectedValues{i}).Y_ROI.leftAnodeROI{j,2});
% pointsCathode(:,1)= pointsCathode(:,1)+single(app.ImageSelection.(selectedValues{i}).Y_ROI.leftCathodeROI{j,2});
% distances = GetDistance(pointsCathode(:,1),pointsAnode(:,1)).* sin((90+angle)/180*pi);
% userdist.Y.(selectedValues{i}).left = distances;
% save('userdist.mat','userdist');
% "end"



% %% Broad X
% i=3;
% j = 200;
% nA=app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI(i,:);
% nC=app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI(i,:);
% 
% %  fig = figure;
% % imshow(nA{1})
% % subplot(1,2,1)
% %imshow(nC{1});
% % subplot(1,2,2)
% % imshow(nA{1});
% 
% %[xa,ya]=getpts;
% %[xc,yc]=getpts;
% angle = extractAngle(app.ImageSelection.(selectedValues{i}).Z)
% pointsAnode = [xa,ya];
% pointsCathode = [xc,yc];
% pointsAnode=sortrows(pointsAnode,2);
% pointsCathode = sortrows(pointsCathode,2);
% pointsAnode(:,1)= pointsAnode(:,1)+single(nA{2}-150);
% pointsCathode(:,1)= pointsCathode(:,1)+single(nC{2}-300);
% distances = GetDistance(pointsCathode(:,1),pointsAnode(:,1)).* cos((90+angle)/180*pi);
%% NARROW X
% i=3;
% j = 50;
% nA=app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI(i,:);
% nC=app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI(i,:);
% 
%  %fig = figure;
% % imshow(nA{1})
% % subplot(1,2,1)
% %imshow(nC{1});
% % subplot(1,2,2)
% % imshow(nA{1});
% 
% %[xa,ya]=getpts;
% %[xc,yc]=getpts;
% angle = extractAngle(app.ImageSelection.(selectedValues{i}).Z)
% % actual_distance_narrow_Y = distance_narrow_Y*cos((90+image_acquisition_angle)/180*pi);
% % actual_distance_broad_Y = distance_broad_Y*sin((90+image_acquisition_angle)/180*pi);
% % actual_distance_narrow_X = distance_narrow_X * sin((90+image_acquisition_angle)/180*pi);
% % actual_distance_broad_X = distance_broad_X*cos((90+image_acquisition_angle)/180*pi);
% pointsAnode = [xa,ya];
% pointsCathode = [xc,yc];
% pointsAnode=sortrows(pointsAnode,2);
% pointsCathode = sortrows(pointsCathode,2);
% pointsAnode(:,1)= pointsAnode(:,1)+single(nA{2}-150);
% pointsCathode(:,1)= pointsCathode(:,1)+single(nC{2}-300);
% distances = GetDistance(pointsCathode(:,1),pointsAnode(:,1)).* sin((90+angle)/180*pi);

"end"
    function distances = GetDistance(pointsCathode,pointsAnode)
        cc =1;
        ca =1;
        for m = 1:29
            distances(m,1)= abs(pointsCathode(cc)-pointsAnode(ca));
            if mod(m,2)==0
                ca = ca+1;
            else
                cc = cc+1;
            end
        end
    end


