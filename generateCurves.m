clc;
clear all;
close all;
%%
load('Outputs/Curves/CurvesImages.mat');
[~,~,~,K,J,Q,T,F] = size(ALL_PS_D);
%% Organize Metrics
cd Quality_Indices
load('pristineModel.mat')
for t=1:T
    for f=1:F
        for j=1:J
            for k=1:K
                for q=1:Q
                    m(q,k,j,f,t) = Qdis(ALL_PS_D(:,:,:,k,j,q,t,f),pristineModel,'norcol');
                end
            end
        end
    end
end
%%
cd ..
save('Outputs/Curves/Curves.mat','-v7.3','m');