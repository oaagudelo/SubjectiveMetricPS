clc;
clear all;
close all;
%% Load Model and Images
load('Outputs/Metrics/ScoreImages.mat')
sensor = 'IKONOS';
ratio = 4;
%% Calculate Metrics
[~,~,~,K,J,Q,T,F]=size(ALL_PS_D);
for k=1:K
    [IQA_EXP(k,1), IQA_EXP(k,2), IQA_EXP(k,3),IQA_EXP(k,4),IQA_EXP(k,5),IQA_EXP(k,6), IQA_EXP(k,7), IQA_EXP(k,8), IQA_EXP(k,9), IQA_EXP(k,10), IQA_EXP(k,11) IQA_EXP(k,12)] = indexes_evaluation(ALL_MS_U(:,:,:,k),ALL_MS(:,:,:,k),ALL_MS_R(:,:,:,k),ALL_PAN_R(:,:,k),sensor,ratio);
    for f=1:F
        [IQA_FUS(k,f,1), IQA_FUS(k,f,2), IQA_FUS(k,f,3),IQA_FUS(k,f,4),IQA_FUS(k,f,5),IQA_FUS(k,f,6), IQA_FUS(k,f,7), IQA_FUS(k,f,8), IQA_FUS(k,f,9), IQA_FUS(k,f,10), IQA_FUS(k,f,11), IQA_FUS(k,f,12)] = indexes_evaluation(ALL_PS(:,:,:,k,f),ALL_MS(:,:,:,k),ALL_MS_R(:,:,:,k),ALL_PAN_R(:,:,k),sensor,ratio);
        for j=1:J
            for q=1:Q
                for t=1:T
                    [IQA_FUS_DIS(k,f,j,q,t,1), IQA_FUS_DIS(k,f,j,q,t,2), IQA_FUS_DIS(k,f,j,q,t,3),IQA_FUS_DIS(k,f,j,q,t,4),IQA_FUS_DIS(k,f,j,q,t,5),IQA_FUS_DIS(k,f,j,q,t,6), IQA_FUS_DIS(k,f,j,q,t,7), IQA_FUS_DIS(k,f,j,q,t,8), IQA_FUS_DIS(k,f,j,q,t,9), IQA_FUS_DIS(k,f,j,q,t,10), IQA_FUS_DIS(k,f,j,q,t,11), IQA_FUS_DIS(k,f,j,q,t,12)] = indexes_evaluation(ALL_PS_D(:,:,:,k,j,q,t,f),ALL_MS_D_T(:,:,:,k,j,q,t),ALL_MS_D_T_R(:,:,:,k,j,q,t),ALL_PAN_D_T_R(:,:,k,j,q,t),sensor,ratio);
                end 
            end
        end
    end
end
save('Outputs/Metrics/IQA.mat','IQA_EXP','IQA_FUS','IQA_FUS_DIS');
%% Organize Tags
T_S = {'Coliseum_','River_','Villa_','Road_','Urban_'};
T_D = {'UD_','Blr_', 'AWGN_'};
T_L = {'UD','Level-1','Level-2','Level-3'};
T_F = {'EXP_','BDSD_','PCA_','IHS_','MTF-GLP-CBD_','ATWT-M2_','HPF_'};
Tag_PSD = Tag_Matrix({T_S,T_F(2:end),T_D(2:end),T_L(2:end)});
Tag_PS  = Tag_Matrix({T_S,T_F(2:end),T_D(1),T_L(1)});
Tag_EXP = Tag_Matrix({T_S,T_F(1),T_D(1),T_L(1)});
Tags = cat(1,Tag_PSD,Tag_PS,Tag_EXP);

%% Organize Metrics
Q = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,1),K*2*3*F,1),reshape(IQA_FUS(:,:,1),K*F,1),IQA_EXP(:,1));
SAM = cat(1,reshape(IQA_FUS_DIS(:,:,:,:,2,2),K*3*3*F,1),reshape(IQA_FUS(:,:,2),K*F,1),IQA_EXP(:,2));
ERGAS = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,3),K*2*3*F,1),reshape(IQA_FUS(:,:,3),K*F,1),IQA_EXP(:,3));
sCC = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,4),K*2*3*F,1),reshape(IQA_FUS(:,:,4),K*F,1),IQA_EXP(:,4));
Q2n = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,5),K*2*3*F,1),reshape(IQA_FUS(:,:,5),K*F,1),IQA_EXP(:,5));
Dl = cat(1,reshape(IQA_FUS_DIS(:,:,:,:,2,6),K*3*3*F,1),reshape(IQA_FUS(:,:,6),K*F,1),IQA_EXP(:,6));
Ds = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,7),K*2*3*F,1),reshape(IQA_FUS(:,:,7),K*F,1),IQA_EXP(:,7));
QNR = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,8),K*2*3*F,1),reshape(IQA_FUS(:,:,8),K*F,1),IQA_EXP(:,8));
Qdis = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,9),K*2*3*F,1),reshape(IQA_FUS(:,:,9),K*F,1),IQA_EXP(:,9));
Qdnor = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,10),K*2*3*F,1),reshape(IQA_FUS(:,:,10),K*F,1),IQA_EXP(:,10));
Qdcol = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,11),K*2*3*F,1),reshape(IQA_FUS(:,:,11),K*F,1),IQA_EXP(:,11));
Qniqe = cat(1,reshape(IQA_FUS_DIS(:,:,1:2,:,1,12),K*2*3*F,1),reshape(IQA_FUS(:,:,12),K*F,1),IQA_EXP(:,12));
%% Generate Table
for l=1:length(Tags)
    data{l,1} = strcat(Tags{l,:});
    data{l,2} = Q(l);
    data{l,3} = ERGAS(l);
    data{l,4} = sCC(l);
    data{l,5} = Q2n(l);
    data{l,6} = Ds(l);
    data{l,7} = QNR(l);
    data{l,8}= Qdnor(l);
    data{l,9}= Qdcol(l);
    data{l,10}= Qdis(l);
    data{l,11}= Qniqe(l);
    data{l,12}= Dl(l)*Qniqe(l);
    data{l,13}= Dl(l)*Qdis(l);
end 
metrics = cell2table(data,'VariableNames',{'Name','Q','ERGAS','sCC','Q2n','Ds','QNR','Qnor','Qcol','Qdis','Qniqe','GQNRn','GQNRd'});
metrics = sortrows(metrics,'Name','descend');
%% Generate Table
clear data
for l=1:length(Tags)
    data{l,1} = strcat(Tags{l,:});
    data{l,2} = SAM(l);
    data{l,3} = Q2n(l);
    data{l,4} = Dl(l);
    data{l,5} = QNR(l);
    data{l,6}= Qdcol(l);
    data{l,7}= Qdis(l);
    data{l,8}= Dl(l)*Qniqe(l);
    data{l,9}= Dl(l)*Qdis(l);
end 
metricsSepec = cell2table(data,'VariableNames',{'Name','SAM','Q2n','Dl','QNR','Qcol','Qdis','GQNRn', 'GQNRd'});
save('Outputs/Metrics/metrics.mat','metrics','metricsSepec');




