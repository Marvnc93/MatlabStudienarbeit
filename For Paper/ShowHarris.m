load('C:\Users\marvn\Desktop\MatlabStudienarbeit\For Paper\cathodeSample.mat');
Img = lessago;
POIfx = 188;
POIfy = 73;
POIox = 279;
POIoy = 108;
size=32;
sizeAxis=300;



cropFor = imcrop(Img,[POIfx-size/2 POIfy-size/2 size-1 size-1] );
[Gxc,Gyc] = imgradientxy(cropFor);
cropOr = imcrop(Img,[POIox-size/2 POIoy-size/2 size-1 size-1] );
[Gxo,Gyo] = imgradientxy(cropOr);







% fig=figure;
% subplot(1,2,1)
% imshow(cropOr);
% hold on
% plot(size/2, size/2,'gx','MarkerSize',12,'LineWidth',2);
% subplot(1,2,2)
% imshow(cropFor);
% hold on
% plot(size/2, size/2,'yx','MarkerSize',12,'LineWidth',2);



%% 3D Images
% fig = figure;
% subplot(1,2,1)
% Xo = uint8(Gxo);
% Yo= uint8(Gyo);
% [X,Y] = meshgrid(1:1:size); 
% %Zo = normalize(Gxo +Gyo,'range');
% Zo = Gxo *Gyo;
% surf(X,Y,Zo);
% %contour(X,Y,Zo);
% xt = get(gca, 'XTick');
% set(gca,'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized','FontWeight','bold')
% xticks([0 8 16])
% yticks([0 8 16])
% subplot(1,2,2)
% Xc = uint8(Gxc);
% Yc= uint8(Gyc);
% [X,Y] = meshgrid(1:1:size); 
% %Zf = normalize(Gxc +Gyc,'range');
% Zf = Gxc* Gyc;
% surf(X,Y,Zf);
% %contour(X,Y,Zf);
% xt = get(gca, 'XTick');
% set(gca,'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized','FontWeight','bold')
% xticks([0 8 16])
% yticks([0 8 16])

%% 2D Interpretation
% fig = figure('Position',[200 200 600 600]);
% 
% fig = figure;
% subplot(1,2,1)
% plot (Gxc,Gyc,'rx');
% ax =gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
% xlim([-sizeAxis sizeAxis])
% ylim([-sizeAxis sizeAxis])
% width=500;
% heght=500;
% subplot(1,2,2)
% plot (Gxo,Gyo,'rx');
% ax =gca;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
% xlim([-sizeAxis sizeAxis])
% ylim([-sizeAxis sizeAxis])
% width=500;
% heght=500;