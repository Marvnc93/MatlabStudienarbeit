function InterpolatePointsX()
%INTERPOLATEPOINTS Summary of this function goes here
%   Detailed explanation goes here
% i=3;
% j=40;
if exist('app','var') ==0
    app = load('D:\Studienarbeit\ProgrammFolder\apptest_PointsX.mat');
    app =app.app;
end
selectedValues=app.FolderSelection.InputFolders.Selected_Values;
drawFigures=true;
stepsForFigures=100;
for i=1:length(selectedValues)
    for j=1:length(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI)
        ROIc = app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI;
        ROIa = app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI;
        %
        pointxc=ROIc{j,5}(:,1);
        pointyc=ROIc{j,5}(:,2);
        pointxa=ROIa{j,5}(:,1);
        pointya=ROIa{j,5}(:,2);
        %
        yqc=min(pointyc):max(pointyc);
        xqc=interp1(pointyc,pointxc,yqc,'spline');
        yqa=min(pointya):max(pointya);
        xqa=interp1(pointya,pointxa,yqa,'spline');
        %
        quotientc = floor(length(xqc)/(length(pointxc)-1));
        interpolatedPointsc = [];
        quotienta = floor(length(xqa)/(length(pointxa)-1));
        interpolatedPointsa = [];
        %
        for k=1:length(pointxc)
            if k ==1
                interpolatedPointsc(k,1) = xqc(1);
                interpolatedPointsc(k,2) = yqc(1);
            elseif k == length(pointxc)
                interpolatedPointsc(k,1) = xqc(end);
                interpolatedPointsc(k,2) = yqc(end);
            else
                interpolatedPointsc(k,1) = xqc(quotientc*k);
                interpolatedPointsc(k,2) = yqc(quotientc*k);
            end
        end
        for k=1:length(pointxa)
            if k ==1
                interpolatedPointsa(k,1) = xqa(1);
                interpolatedPointsa(k,2) = yqa(1);
            elseif k == length(pointxa)
                interpolatedPointsa(k,1) = xqa(end);
                interpolatedPointsa(k,2) = yqa(end);
            else
                interpolatedPointsa(k,1) = xqa(quotienta*k);
                interpolatedPointsa(k,2) = yqa(quotienta*k);
            end
        end
        %plot(xqc,yqc,'-');
        
        %plot(interpolatedPointsc(:,1),interpolatedPointsc(:,2),'rx')
        if drawFigures==true && mod(j,stepsForFigures)==0
            fig = figure('visible','off',...
                'Position',[500 300 500 700]);
            
            A =imread(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,4});
            imshow(A);
            hold on;
            plot(pointxc+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,2}-99),pointyc,'gx');
            hold on;
            plot(pointxa+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,2}-99),pointya,'gx');
            hold on;
            plot(xqc+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,2}-99),yqc,'b-');
            hold on;
            plot(xqa+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,2}-99),yqa,'b-');
            hold on;
            plot(interpolatedPointsc(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,2}-99),interpolatedPointsc(:,2),'rx');
            hold on;
            plot(interpolatedPointsa(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,2}-99),interpolatedPointsa(:,2),'rx');
            title('Full Picture');
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\InterpolX\Narrow\',int2str(i),filesep,int2str(j),'.png'));
            
        end
    end
end

