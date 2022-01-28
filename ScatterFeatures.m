close all;
clear all;
clc;
%%
load('Outputs/ScatterFeatures/ImagesFeatures.mat');
%%
% Reshape Matrices
[M,N,L,K,J,Q,T,F]=size(ALL_PS_D);
ALL_PS = reshape(ALL_PS,M,N,L,K*F);
ALL_PS_D = reshape(ALL_PS_D,M,N,L,K*J*Q*T*F);
ALL_IM = cat(4,ALL_PS_D,ALL_PS,ALL_MS_U,ALL_MS);
ALL_IM_FMS = Features_Group(ALL_IM,'normal+color+norcol');
save('Outputs/ScatterFeatures/Data_Features.mat','-v7.3','ALL_IM_FMS');