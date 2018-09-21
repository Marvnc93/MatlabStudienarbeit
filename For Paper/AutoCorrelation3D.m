[X,Y] = meshgrid(-5:0.5:5); 
%Flat
Zf = 0.1*X.^2 + 0.1*Y.^2
%Ridge
Zr= 2*Y.^2
%Corner
Zc = X.^2+Y.^2;


ha = tight_subplot(1,3,[0.1 0.1],[.1 .1],[.1 .1]);

axes(ha(1));
surf(X,Y,Zf);
ylabel("(a)",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.2, 0.5, 0],'FontWeight','bold');
%set(gca,'ztick',[],'xtick',[],'ytick',[]);
axis([-5 5 -5 5 0 50]);
axes(ha(2));
surf(X,Y,Zr);
ylabel("(b)",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.2, 0.5, 0],'FontWeight','bold');
%set(gca,'ztick',[],'xtick',[],'ytick',[]);
axis([-5 5 -5 5 0 50]);
axes(ha(3));
surf(X,Y,Zc);
ylabel("(c)",'FontSize',12,'FontName','LM ROMAN 12','Units', 'Normalized', 'Position', [-0.2, 0.5, 0],'FontWeight','bold');
%set(gca,'ztick',[],'xtick',[],'ytick',[]);
axis([-5 5 -5 5 0 50]);