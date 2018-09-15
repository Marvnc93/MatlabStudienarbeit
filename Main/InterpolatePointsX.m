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
stepsForFigures=10;
%% X-Narrow
for i=1:1%length(selectedValues)
    for j=1:length(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI)
        %last char: c=cathode a=anode
        ROIc = app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI;
        ROIa = app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI;
        % Get the x and y points found by Point_extractionX
        pointxc=ROIc{j,5}(:,1);
        pointyc=ROIc{j,5}(:,2);
        pointxa=ROIa{j,5}(:,1);
        pointya=ROIa{j,5}(:,2);
        %
        yInterpolc=linspace(min(pointyc),max(pointyc),800);
        xInterpolc=interp1(pointyc,pointxc,yInterpolc,'spline');
        yInterpola=linspace(min(pointya),max(pointya),800);
        xInterpola=interp1(pointya,pointxa,yInterpola,'spline');
        %
        quotientc = floor(length(xInterpolc)/(length(pointxc)-1));
        interpolatedPointsc = [];
        quotienta = floor(length(xInterpola)/(length(pointxa)-1));
        interpolatedPointsa = [];
        %
        for k=1:length(pointxc)
            if k ==1
                interpolatedPointsc(k,1) = xInterpolc(1);
                interpolatedPointsc(k,2) = yInterpolc(1);
            elseif k == length(pointxc)
                interpolatedPointsc(k,1) = xInterpolc(end);
                interpolatedPointsc(k,2) = yInterpolc(end);
            else
                interpolatedPointsc(k,1) = xInterpolc(quotientc*(k-1));
                interpolatedPointsc(k,2) = yInterpolc(quotientc*(k-1));
            end
        end
        for k=1:length(pointxa)
            if k ==1
                interpolatedPointsa(k,1) = xInterpola(1);
                interpolatedPointsa(k,2) = yInterpola(1);
            elseif k == length(pointxa)
                interpolatedPointsa(k,1) = xInterpola(end);
                interpolatedPointsa(k,2) = yInterpola(end);
            else
                interpolatedPointsa(k,1) = xInterpola(quotienta*(k-1));
                interpolatedPointsa(k,2) = yInterpola(quotienta*(k-1));
            end
        end
        
        realDistancePointsc = [interpolatedPointsc(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,2}-99),interpolatedPointsc(:,2)];
        realDistancePointsa = [interpolatedPointsa(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,2}-99),interpolatedPointsa(:,2)];
        CalcDistance(realDistancePointsc,realDistancePointsa,"X-Narrow");
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
            plot(xInterpolc+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowCathodeROI{j,2}-99),yInterpolc,'b-');
            hold on;
            plot(xInterpola+single(app.ImageSelection.(selectedValues{i}).X_ROI.narrowAnodeROI{j,2}-99),yInterpola,'b-');
            hold on;
            plot(realDistancePointsc(:,1),interpolatedPointsc(:,2),'rx');
            hold on;
            plot(realDistancePointsa(:,1),interpolatedPointsa(:,2),'rx');
            title('Full Picture');
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\InterpolX\Narrow\',int2str(i),filesep,int2str(j),'.png'));
            
        end
    end
end
%% X-Broad
for i=1:length(selectedValues)
    for j=1:length(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI)
        %last char: c=cathode a=anode
        ROIc = app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI;
        ROIa = app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI;
        % Get the x and y points found by Point_extractionX
        pointxc=ROIc{j,5}(:,1);
        pointyc=ROIc{j,5}(:,2);
        pointxa=ROIa{j,5}(:,1);
        pointya=ROIa{j,5}(:,2);
        %
        yInterpolc=linspace(min(pointyc),max(pointyc),800);
        xInterpolc=interp1(pointyc,pointxc,yInterpolc,'spline');
        yInterpola=linspace(min(pointya),max(pointya),800);
        xInterpola=interp1(pointya,pointxa,yInterpola,'spline');
        %
        quotientc = floor(length(xInterpolc)/(length(pointxc)-1));
        interpolatedPointsc = [];
        quotienta = floor(length(xInterpola)/(length(pointxa)-1));
        interpolatedPointsa = [];
        %
        for k=1:length(pointxc)
            if k ==1
                interpolatedPointsc(k,1) = xInterpolc(1);
                interpolatedPointsc(k,2) = yInterpolc(1);
            elseif k == length(pointxc)
                interpolatedPointsc(k,1) = xInterpolc(end);
                interpolatedPointsc(k,2) = yInterpolc(end);
            else
                interpolatedPointsc(k,1) = xInterpolc(quotientc*(k-1));
                interpolatedPointsc(k,2) = yInterpolc(quotientc*(k-1));
            end
        end
        for k=1:length(pointxa)
            if k ==1
                interpolatedPointsa(k,1) = xInterpola(1);
                interpolatedPointsa(k,2) = yInterpola(1);
            elseif k == length(pointxa)
                interpolatedPointsa(k,1) = xInterpola(end);
                interpolatedPointsa(k,2) = yInterpola(end);
            else
                interpolatedPointsa(k,1) = xInterpola(quotienta*(k-1));
                interpolatedPointsa(k,2) = yInterpola(quotienta*(k-1));
            end
        end
        realDistancePointsc = [interpolatedPointsc(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,2}-99),interpolatedPointsc(:,2)];
        realDistancePointsa = [interpolatedPointsa(:,1)+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI{j,2}-99),interpolatedPointsa(:,2)];
        %% Draw Figures
        if drawFigures==true && mod(j,stepsForFigures)==0
            fig = figure('visible','off',...
                'Position',[500 300 500 700]);
            
            A =imread(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,4});
            imshow(A);
            hold on;
            plot(pointxc+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,2}-99),pointyc,'gx');
            hold on;
            plot(pointxa+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI{j,2}-99),pointya,'gx');
            hold on;
            plot(xInterpolc+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadCathodeROI{j,2}-99),yInterpolc,'b-');
            hold on;
            plot(xInterpola+single(app.ImageSelection.(selectedValues{i}).X_ROI.broadAnodeROI{j,2}-99),yInterpola,'b-');
            hold on;
            plot(realDistancePointsc(:,1),interpolatedPointsc(:,2),'rx');
            hold on;
            plot(realDistancePointsa(:,1),interpolatedPointsa(:,2),'rx');
            title('Full Picture');
            saveas(fig,strcat('D:\Studienarbeit\ProgrammFolder\InterpolX\Broad\',int2str(i),filesep,int2str(j),'.png'));
            
        end
    end
end
end

