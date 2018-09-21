clear all; close all;

%% Plot
fontSize = 12;

set(0,'defaulttextinterpreter','latex')
set(0,'DefaultTextFontname', 'LM Roman 12')
set(0,'DefaultAxesFontName', 'LM Roman 12')
set(0, 'DefaultAxesFontSize', fontSize)
set(0,'DefaultLineLineWidth',2)

blue = [1,87,155]./255;
cyan = [0,172,193]./255;
red = [198,40,40]./255;
grey = [68,89,99]./255;
green = [56,142,60]./255;
olive = [130,119,23]./255;
brown = [109,76,65]./255;
orange = [255,111,0]./255;

A=repmat([2,2,2,2,2,8,8,8,8,8],6);
A=A(:,1:10);
sob = transpose(fspecial('Sobel'));
lab = fspecial('Laplacian',1);
ResSob = conv2(A,sob);
ResLab= conv2(A,lab);
%lapl = fspecial('laplacian',1);