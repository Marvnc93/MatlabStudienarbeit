function cell = CreateAlgorithmCell()

cell ={"preprocessing","preprocessingMode","imageSmoothen","imageSmoothenMode","GaussFilter","Anisoiter",...
    "imageSharpen","binarize","binarizeMode","structure","structureMode","structureShape","algorithm","algorithmFilterSize"};
counter=2;

preprocessing = {"off","on"};
%Reduced after first results
%preprocessingMode = {"Otsu", "Mean", "Quartile"};
preprocessingMode = {"Mean"};
imageSmoothen = {"off","on"};
imageSmoothenMode = {"Gauﬂ","Anisotropic"};
%First Value filter Size, Second Value sigma
GaussFilter = {{7 2},{5 2}};
Anisoiter = {5,15};

imageSharpen = {"off","Laplace"};

binarize = {"off","on"};
%Reduced after first tests
%binarizeMode = {"Thresholding","Sobel","EarlySobel"};
binarizeMode={"EarlySobel"};

structure = {"off","on"};
structureMode = {"open","close"};
structureShape = {{'rectangle',[3,1]},{'rectangle',[1,3]}};


algorithm = {"Harrison"};%,"ShiTomasi"};%,"SURF","BRISK"};
algorithmSize = {5,7,9};


for i=1:numel(preprocessing)
    for j=1:numel(preprocessingMode)
        for k=1:numel(imageSmoothen)
            for m=1:numel(imageSmoothenMode)
                for n=1:numel(imageSharpen)
                    for o=1:numel(binarize)
                        for p=1:numel(binarizeMode)
                            for q=1:numel(structure)
                                for r=1:numel(structureMode)
                                    for s=1:numel(structureShape)
                                        for t = 1:numel(algorithm)
                                            for u = 1:numel(algorithmSize)
                                            %Remove unecesarry rows
                                            if imageSmoothen{k}=="on"
                                                for m1=1:numel(GaussFilter)
                                                    for m2=1:numel(Anisoiter)
                                                        
                                                        cell(counter,:) = [preprocessing(i),preprocessingMode(j),...
                                                            imageSmoothen(k),imageSmoothenMode(m),GaussFilter(m1),Anisoiter(m2)...
                                                            imageSharpen(n),...
                                                            binarize(o),binarizeMode(p),...
                                                            structure(q),structureMode(r),structureShape(s),...
                                                            algorithm(t),algorithmSize(u)];
                                                        counter = counter+1;
                                                    end
                                                end
                                            else
                                                cell(counter,:) = [preprocessing(i),preprocessingMode(j),...
                                                    imageSmoothen(k),{""},{""},{""}...
                                                    imageSharpen(n),...
                                                    binarize(o),binarizeMode(p),...
                                                    structure(q),structureMode(r),structureShape(s),...
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
        end
    end
end



end

