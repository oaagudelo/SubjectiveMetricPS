close all;
clear all;
clc;
%%
load('Outputs/Metrics/ScoreImages.mat');
%%
[M,N,L,K,J,Q,T,F]=size(ALL_PS_D(:,:,:,:,1:2,:,1,:));
ALL_PS = reshape(ALL_PS,M,N,L,K*F);
ALL_PS_D = reshape(ALL_PS_D(:,:,:,:,1:2,:,1,:),M,N,L,K*J*Q*T*F);
ALL_IM = cat(4,ALL_PS_D,ALL_PS,ALL_MS_U);
ALL_IM_FMS = Features_Group(ALL_IM,'normal+color+norcol');
save('Outputs/ScatterFeatures/Data_Features.mat','-v7.3','ALL_IM_FMS');

%% Organize Tags
T_S = {'Coliseum_','River_','Villa_','Road_','Urban_'};
T_D = {'UD_','Blr_', 'AWGN_'};
T_L = {'UD','Level-1','Level-2','Level-3'};
T_F = {'EXP_','BDSD_','PCA_','IHS_','MTF-GLP-CBD_','ATWT-M2_','HPF_'};
Tag_PSD = Tag_Matrix({T_S,T_F(2:end),T_D(2:end),T_L(2:end)});
Tag_PS  = Tag_Matrix({T_S,T_F(2:end),T_D(1),T_L(1)});
Tag_EXP = Tag_Matrix({T_S,T_F(1),T_D(1),T_L(1)});
Tags = cat(1,Tag_PSD,Tag_PS,Tag_EXP);
%% Generate Table
for l=1:length(Tags)
    data{l,1} = strcat(Tags{l,:});
    data{l,2} = ALL_IM_FMS.norcol(l,:);
end 
features = cell2table(data,'VariableNames',{'Name','Feature'});
features = sortrows(features,'Name','descend');
features = table2array(features(:,2:end));
save('Outputs/Features/features.mat','features');
