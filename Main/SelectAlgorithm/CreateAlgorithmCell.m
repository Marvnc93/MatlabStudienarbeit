function [cell,gc,se,ses,sh,alg,grp] = CreateAlgorithmCell()

cell ={};
counter=1;
greyCutoff ={"on","off"};
structureElement = {"on","off"};
structureElementShape = {{'rectangle',[2,2]},{'rectangle',[3,3]}};%,{'rectangle',[4,4]},{'rectangle',[5,5]},{'rectangle',[5,10]}};
algorithm = {"Harrison","ShiTomasi"};%,"SURF","BRISK"};
sharpen = {"on","off"};
grouping ={'Gauss','off'};

for i=1:numel(greyCutoff)
    for j=1:numel(structureElement)
        for k=1:numel(structureElementShape)
            for m=1:numel(sharpen)
                for n=1:numel(algorithm)
                    for o=1:numel(grouping)
                    cell(counter,:) = [greyCutoff(i),structureElement(j),structureElementShape(k),sharpen(m),algorithm(n),grouping(o)];
                    counter = counter+1;
                    end
                
            end
        end
    end
end

gc=cell(:,1);
se=cell(:,2);
ses=cell(:,3);
sh=cell(:,4);
alg=cell(:,5);
grp =cell(:,6);

end

