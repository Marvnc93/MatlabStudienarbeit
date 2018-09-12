function [cell,gc,se,ses,sh,alg] = CreateAlgorithmCell()

cell ={};
counter=1;
greyCutoff ={"on","off"};
structureElement = {"on","off"};
structureElementShape = {{'rectangle',[2,2]},{'rectangle',[3,3]},{'rectangle',[4,4]},{'rectangle',[5,5]},{'rectangle',[5,10]}};
algorithm = {"Harrison","ShiTomasi","SURF","BRISK"};
sharpen = {"on","off"};

for i=1:numel(greyCutoff)
    for j=1:numel(structureElement)
        for k=1:numel(structureElementShape)
            for m=1:numel(sharpen)
                for n=1:numel(algorithm)
                    cell(counter,:) = [greyCutoff(i),structureElement(j),structureElementShape(k),sharpen(m),algorithm(n)];
                    counter = counter+1;
                
            end
        end
    end
end

gc=cell(:,1);
se=cell(:,2);
ses=cell(:,3);
sh=cell(:,4);
alg=cell(:,5);

end

