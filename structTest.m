function features=structTest(cA,cH,cV,cD)

for i=1:4
    %detail matrix based on which row
    if i==1
        matrix=cA;
        direction='Average';
    elseif i==2
        matrix=cH;
        direction='Horizantal';
    elseif i==3
        matrix=cV;
        direction='Vertical';
    elseif i==4
        matrix=cD;
        direction='Diagonal';
    end
    %fill in each row with features
    for i2=1:8
        %energy
        if i2==1
            energy=sum((matrix(:)).^2);
            %entropy
        elseif i2==2
            ent=0;
            xCol=reshape(matrix,[],1);
            ent=sum(xCol(xCol~=0).*log(xCol(xCol~=0)));
            %                 ind1=find(xCol~=0);
            %                 ind2=find(isnan(xCol));
            %                 entropy=sum(xCol(x || find(xCol~=isnan(xCol))))*
            %                 log(xCol(xCol~=0)));
            % homogeneity
        elseif i2==3
            homogeneity=0;
            for i4=1:size(matrix,1)
                for i5=1:size(matrix,2)
                    homogeneity=homogeneity+matrix(i4,i5)/(1+(i4-i5)^2);
                end
            end
            %contrast
        elseif i2==4
            contrast=0;
            for i6=1:size(matrix,1)
                for i7=1:size(matrix,2)
                    contrast=contrast+matrix(i6,i7)^2*(i6-i7)^2;
                end
            end
            %standard deviation
        elseif i2==5
            standardDeviation=std(matrix(:));
            %variance
        elseif i2==6
            variance=var(matrix(:));
            %energy using that weird paper
        elseif i2==7
            energy2=sum(matrix(:))/(size(matrix,1)*size(matrix,2));
            
        end              
    end
    features=struct('direction',direction,'energy',energy,'entropy',ent,'homogeneity',homogeneity,'contrast', contrast,'standarddeviation', standardDeviation, 'variance',variance, 'energy2', energy2);
end







