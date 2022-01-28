clear
clc
close all
%%
load('Outputs/Features/features.mat');
load('Outputs/Metrics/metrics.mat');
load('Datasets/score/SS.mat');
cd Quality_Indices
load('SVMmodel.mat');
cd ..
dmosGM = sqrt(dmos(1:end/2).*dmos(end/2+1:end));
dmosAM =(dmos(1:end/2)+dmos(end/2+1:end))/2;
dmosTC = dmos(1:end/2);
dmosPC = dmos(end/2+1:end);
metrics  = table2array(metrics(:,2:end));
%%
[N,~] = size(features);
trainproportion = 0.8;
Ntrain = ceil(trainproportion*N);
[features, features, ~] = scaleSVM(features, features, features, 0, 1);
predictedScores = svmpredict(dmosGM, features, bestModel);
logmetric = lognonfun(predictedScores,'fun',bestBeta);
[~, gof] = fit(predictedScores,dmosGM,'poly1');
r = gof.rsquare;
scatter(predictedScores, dmosGM)
hold on
[~,index] = sort(predictedScores);
plot(predictedScores(index),logmetric(index),'--r')
text(60,50,strcat('R^2 = ',num2str(r)))
ylabel('DMOS')
xlabel('Q_{OA}')
%%
% Determine the train and test index
for i=1:1000
    randomIndexer = randperm(N);
    trainIndex = zeros(N,1); trainIndex(randomIndexer(1:Ntrain)) = 1;
    testIndex = zeros(N,1); testIndex(randomIndexer(Ntrain+1:N)) = 1;
    
    trainFeatures = features(trainIndex==1,:);
    trainScores = dmosGM(trainIndex==1,:);
    testFeatures = features(testIndex==1,:);
    testScores = dmosGM(testIndex==1,:);
     
    for k=1:12
        [~,beta] = lognonfun(metrics(trainIndex==1,k),'train',trainScores);
        logmetric = lognonfun(metrics(testIndex==1,k),'fun',beta);
        R(k,1,i) = abs(corr(testScores,logmetric,'Type','Spearman'));
        R(k,2,i) = abs(corr(testScores,logmetric,'Type','Pearson'));
        R(k,3,i) = sqrt(mean((testScores-logmetric).^2));
    end
    
    [trainFeatures, testFeatures, ~] = scaleSVM(trainFeatures, testFeatures, trainFeatures, 0, 1);
    param = ['-q -s 3 -t 2 -c ', num2str(2^bestLog2c), ' -g ', num2str(2^bestLog2g)];
    Model = svmtrain(trainScores, trainFeatures, param);
    predtrainScores = svmpredict(trainScores, trainFeatures, Model);
    predictedScores = svmpredict(testScores, testFeatures, Model);
    [~,beta] = lognonfun(predtrainScores,'train',trainScores);
    logmetric = lognonfun(predictedScores,'fun',beta);
    R(13,1,i) = abs(corr(logmetric,testScores,'Type','Spearman'));
    R(13,2,i) = abs(corr(logmetric,testScores,'Type','Pearson'));
    R(13,3,i) = sqrt(mean((logmetric-testScores).^2));
      
end
m = median(R,3,'omitnan');
s = std(R,0,3,'omitnan');
f = m(:,[1;1]*(1:size(m,2)));
f(:,2:2:end) = s;
%%
matrix2latex(f,'Outputs/Metrics/Tables/VarTest.tex','rowLabels',[{'$Q_q$'},{'$Q_\text{ERGAS}$'},{'$Q_\text{sCC}$'},{'$Q_{q_4}$'},{'$Q_{d_s}$'},{'$Q_\text{QNR}$'},{'$Q_S$'},{'$Q_C$'},{'$Q_D$'},{'$Q_\text{NIQE}$'},{'$Q_\text{GQNRn}$'},{'$Q_\text{GQNRd}$'},{'$Q_\text{OA}$'}],...
            'columnLabels',[{'$M_\text{SRCC}$'},{'$\sigma_\text{SRCC}$'},{'$M_\text{LCC}$'},{'$\sigma_\text{LCC}$'},{'$M_\text{RMSE}$'},{'$\sigma_\text{RMSE}$'}],'alignment','c','format', '%.4f');
        
%% 
for i=1:13
    for j=1:13
        a = R(i,1,:);
        b = R(j,1,:);
        if kruskalwallis([a(:),b(:)], [], 'off') <= 0.05
            if median(a(:),'omitnan') > median(b(:),'omitnan')
                CompMat{i, j} = '1';
            else
                CompMat{i, j} = '0';
            end
        else
            CompMat{i, j} = '-';
        end
    end
end

matrix2latex(CompMat,'Outputs/Metrics/Tables/StatTest.tex','rowLabels',[{'$Q_q$'},{'$Q_\text{ERGAS}$'},{'$Q_\text{sCC}$'},{'$Q_{q_4}$'},{'$Q_{d_s}$'},{'$Q_\text{QNR}$'},{'$Q_S$'},{'$Q_C$'},{'$Q_D$'},{'$Q_\text{NIQE}$'},{'$Q_\text{GQNRn}$'},{'$Q_\text{GQNRd}$'},{'$Q_\text{OA}$'}],...
            'columnLabels',[{'$Q_q$'},{'$Q_\text{ERGAS}$'},{'$Q_\text{sCC}$'},{'$Q_{q_4}$'},{'$Q_{d_s}$'},{'$Q_\text{QNR}$'},{'$Q_S$'},{'$Q_C$'},{'$Q_D$'},{'$Q_\text{NIQE}$'},{'$Q_\text{GQNRn}$'},{'$Q_\text{GQNRd}$'},{'$Q_\text{OA}$'}],'alignment','c','format', '%s');
