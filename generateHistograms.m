close all;
clear all;
clc;
%%
load('Outputs/ScatterFeatures/ImagesFeatures.mat');
[M,N,L,K,J,Q,T,F]=size(ALL_PS_D);

%%
for f=1:F
    Cimage = chromams(ALL_PS(:,:,:,:,f));
    [D0(:,:,1,f),X0(:,:,1,f)] = computeGoodallHist(ALL_PS(:,:,:,:,f)); 
    [D0(:,:,2,f),X0(:,:,2,f)] = computeGoodallHist(Cimage);
end

%%
for q=1:Q    
    for t=1:T
        for f=1:F
            for j=1:J
                Cimage = chromams(ALL_PS_D(:,:,:,:,j,q,t,f));
                [D(:,:,1,j,q,t,f),X(:,:,1,j,q,t,f)] = computeGoodallHist(ALL_PS_D(:,:,:,:,j,q,t,f));                                               
                [D(:,:,2,j,q,t,f),X(:,:,2,j,q,t,f)] = computeGoodallHist(Cimage);
            end
        end
    end
end
%%
save('Outputs/Histograms.mat','D','X','D0','X0');