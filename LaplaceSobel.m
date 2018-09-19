A=repmat([2,2,2,2,2,8,8,8,8,8],6);
A=A(:,1:10);
sob = transpose(fspecial('Sobel'));
lab = fspecial('Laplacian',1);
ResSob = conv2(A,sob);
ResLab= conv2(A,lab);
%lapl = fspecial('laplacian',1);