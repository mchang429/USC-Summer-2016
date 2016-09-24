function x = decomp(pic, wavelet, level)

%read in picture
pic1=imread(pic);

%size of image
pic1=padarray(pic1,2,'replicate');
picDim=size(pic1);

imshow(pic1);

%% Single Wavelet Decomposition
% [cA1,cH1,cV1,cD1] = dwt2(pic1,wavelet);
% A1 = upcoef2('a',cA1,wavelet,1);
% H1 = upcoef2('h',cH1,wavelet,1);
% V1 = upcoef2('v',cV1,wavelet,1);
% D1 = upcoef2('d',cD1,wavelet,1);

%% set up cells and matrices

%create cell array of matrices
lvl=cell(level,4);
%each matrix is size of image/(2*level of decomp)
for i3=1:level
    lvl(i3)={zeros(picDim)};
end
 
%matrix for reconstructed coefficients
matRec=cell(level,3);

%cell to save features
%cH [energy entropy homogeneity...]
%cV [energy entropy homogeneity...]
%cD [energy entropy homogeneity...]

matFeat=cell(1,level);
% for i4=1:level
%     cellFeat(i4)={zeros(3,11)};
% end

%% Multi-level Wavelet Decomposition

%Decomposition
[c,s]=wavedec2(pic1,level,wavelet);

%(1,1) is hCoef
%(2,1) is vCoef
%(3,1) is dCoef
%fill matrix with coefficeints
for i=1:level
    lvl{i,1}=appcoef2(c,s,wavelet,2);
    [lvl{i,2}, lvl{i,3}, lvl{i,4}]=detcoef2('all',c,s,i);
    
    %reconstruct decomposed values
%     matRec{i,1}=wrcoef('H1',c,s,wavelet,i);
%     matRec{i,2}=wrcoef('V1',c,s,wavelet,i);
%     matRec{i,3}=wrcoef('D1',c,s,wavelet,i);
end

%% Calculations for cerompletely reconstructed image

%reconstruct
% x0=waverec2(c,s,level);
% 
% %reshape
% xCol=reshape(x0,[],1);
% 
% %energy
% energy=sum(xCol.^2);
% 
% fprintf('Energy=%8.4',energy);
% 
% %entropy
% entropy=sum(xCol(xCol~=0).*log(xCol(xCol~=0)));
% 
% fprintf('Entropy=%8.4', entropy);

%% Calculations for levels of composition
%Uses the function cellFeat
for i2=1:level
    x(i2) = structTest(lvl{i2,1},lvl{i2,2},lvl{i2,3},lvl{i2,4});
end


 
        
        
        
        
        
        %%
        % [thr, sorh, keepapp]=ddencmp('cmp','wv', pic1);
        % [rcccomp,cxc,lxc,perf0,perfl2]=wdencmp('gbl',c,s,'db2', 1, thr, sorh, keepapp);
        %
        % subplot(1,2,1); image(pic1); title('Original Image');
        % axis square
        % subplot(1,2,2); image(rcccomp); title('Contrast Enhanced Image');
        % axis square
        
        
        