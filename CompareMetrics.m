clc;
clear all;
close all;
%% Load Scores
load('Datasets/score/SS.mat')
load('Outputs/Metrics/metrics.mat');
%% Organize Scores
dmosGM = sqrt(dmos(1:end/2).*dmos(end/2+1:end));
dmosAM =(dmos(1:end/2)+dmos(end/2+1:end))/2;
dmosTC = dmos(1:end/2);
dmosPC = dmos(end/2+1:end);
DMOS = [dmosGM dmosAM dmosTC dmosPC];
metrics  = table2array(metrics(:,2:end));
metricsSpec  = table2array(metricsSepec(:,2:end));
%%
dmosName = {'dmosGM','dmosAM','dmosTC','dmosPC'};
for k =1:4
    for i=1:12
        logmetric = lognonfun(metrics(:,i),'train',DMOS(:,k));
        R(i,1,k) = abs(corr(DMOS(:,k),logmetric,'Type','Spearman'));
        R(i,2,k) = abs(corr(DMOS(:,k),logmetric,'Type','Pearson'));
        R(i,3,k) = sqrt(mean((DMOS(:,k)-logmetric).^2));
    end
    matrix2latex(R(:,:,k),strcat('Outputs/Metrics/Tables/',dmosName{k},'.tex'), 'rowLabels',[{'$Q_q$'},{'$Q_\text{ERGAS}$'},{'$Q_\text{sCC}$'},{'$Q_{q_4}$'},{'$Q_{d_s}$'},{'$Q_\text{QNR}$'},{'$Q_S$'},{'$Q_C$'},{'$Q_D$'},{'$Q_\text{NIQE}$'},{'$Q_\text{GQNRn}$'},{'$Q_\text{GQNRd}$'}],...
            'columnLabels',[{'SRCC'},{'LCC'},{'RMSE'}],'alignment','c','format', '%.4f');
end
%%
for i=1:8
    for j =1:8
            REF = rescale(metricsSpec(:,i));
            logmetric = lognonfun(metricsSpec(:,j),'train',REF);
            Sp{i,j} = num2str(abs(corr(REF,logmetric,'Type','Spearman')),'%.4f');
            Pr{i,j} = num2str(abs(corr(REF,logmetric,'Type','Pearson')),'%.4f');
            Er{i,j} = num2str(sqrt(mean((REF-logmetric).^2)),'%.2f');
    end
end
matrix2latex(Sp,strcat('Outputs/Metrics/Tables/spectral.tex'), 'rowLabels',[{'$Q_\text{SAM}$'},{'$Q_{q_4}$'},{'$Q_{d_\lambda}$'},{'$Q_\text{QNR}$'},{'$Q_C$'},{'$Q_D$'},{'$Q_\text{GQNRn}$'},{'$Q_\text{GQNRd}$'}],...
            'columnLabels',[{'$Q_\text{SAM}$'},{'$Q_{q_4}$'},{'$Q_{d_\lambda}$'},{'$Q_\text{QNR}$'},{'$Q_C$'},{'$Q_D$'},{'$Q_{GQNRn}$'},{'$Q_{GQNRd}$'}],'alignment','c','format', '%s');
        
%%
T_D = {'UD','Blr', 'AWGN'};
T_F = {'EXP','BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};

for i =1:7
    comp = dmosGM(contains(names(1:end/2),T_F{i}));
    namc = names(contains(names(1:end/2),T_F{i}));
    for j = 1: 3
        m(i,j) = mean(comp(contains(namc,T_D{j})));
        s(i,j) = std(comp(contains(namc,T_D{j})));
    end
end
f = m(:,[1;1]*(1:size(m,2)));
f(:,2:2:end) = s;
matrix2latex(f,strcat('Outputs/Metrics/Tables/besttech.tex'), 'rowLabels',[{'EXP'},{'BDSD'},{'PCA'},{'IHS'},{'MTF-GLP-CBD'},{'ATWT-M2'},{'HPF'}],...
            'columnLabels',[{'$\bar(I)_\text{UD}$'},{'$\sigma_\text{UD}$'},{'$\bar(I)_\text{AWGN}$'},{'$\sigma_\text{AWGN}$'},{'$\bar(I)_\text{Blur}$'},{'$\sigma_\text{Blur}$'}],'alignment','c','format', '%.4f');
  