function cell = CreateAlgorithmCell()

cell ={"preprocessing","preprocessingMode","imageSmoothen","imageSmoothenMode","GaussFilter","Anisoiter",...
    "imageSharpen","algorithm","algorithmFilterSize"};
%,"binarize","binarizeMode","structure","structureMode","structureShape"
counter=2;

preprocessing = {"on"};
preprocessingMode = {"Mean"};
%Reduced after first run
%preprocessing = {"off","on"};
%Reduced after first test
%preprocessingMode = {"Otsu", "Mean", "Quartile"};

imageSmoothen = {"off","on"};
imageSmoothenMode = {"Gauﬂ","Anisotropic"};
%First Value filter Size, Second Value sigma
GaussFilter = {[7 2],[5 2]};
Anisoiter = {5,15};

imageSharpen = {"off","Laplace"};

%Reduced after first run
%binarize = {"off","on"};
%binarizeMode={"EarlySobel"};
%Reduced after first tests
%binarizeMode = {"Thresholding","Sobel","EarlySobel"};

%Reduced after first run
% structure = {"off","on"};
% structureMode = {"open","close"};
% structureShape = {{'rectangle',[3,1]},{'rectangle',[1,3]}};


algorithm = {"Harrison"};%,"ShiTomasi"};%,"SURF","BRISK"};
algorithmSize = {9,11};
%Changed after first run
%algorithmSize = {5,7,9};


for i=1:numel(preprocessing)
    for j=1:numel(preprocessingMode)
        for k=1:numel(imageSmoothen)
            for m=1:numel(imageSmoothenMode)
                for n=1:numel(imageSharpen)
                    for t = 1:numel(algorithm)
                        for u = 1:numel(algorithmSize)
                            for m1=1:numel(GaussFilter)
                                for m2=1:numel(Anisoiter)
                                    
                                    cell(counter,:) = [preprocessing(i),preprocessingMode(j),...
                                        imageSmoothen(k),imageSmoothenMode(m),GaussFilter(m1),Anisoiter(m2)...
                                        imageSharpen(n),...
                                        algorithm(t),algorithmSize(u)];
                                    counter = counter+1;
                                    
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end




end

