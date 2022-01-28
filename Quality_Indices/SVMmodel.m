clear
clc
close all
%%
cd ..
load('Outputs/Features/features.mat');
load('Datasets/score/SS.mat')
dmosGM = sqrt(dmos(1:end/2).*dmos(end/2+1:end));
dmosAM =(dmos(1:end/2)+dmos(end/2+1:end))/2;
dmosTC = dmos(1:end/2);
dmosPC = dmos(end/2+1:end);
%%
[N,~] = size(features);
trainproportion = 0.8;
Ntrain = ceil(trainproportion*N);
% Determine the train and test index
randomIndexer = randperm(N);

trainIndex = zeros(N,1); trainIndex(randomIndexer(1:Ntrain)) = 1;
testIndex = zeros(N,1); testIndex(randomIndexer(Ntrain+1:N)) = 1;

trainFeatures = features(trainIndex==1,:);
trainScores = dmosGM(trainIndex==1,:);
testFeatures = features(testIndex==1,:);
testScores = dmosGM(testIndex==1,:);
%%
[trainFeatures, testFeatures, ~] = scaleSVM(trainFeatures, testFeatures, trainFeatures, 0, 1);

% ###################################################################
% From here on, we do 3-fold cross validation on the train data set
% ###################################################################

% ###################################################################
% cross validation scale 1
% This is the big scale (rough)
% ###################################################################
stepSize = 1;
log2c_list = -20:stepSize:20;
log2g_list = -20:stepSize:20;

numLog2c = length(log2c_list);
numLog2g = length(log2g_list);
cvMatrix = zeros(numLog2c,numLog2g);
bestcv = 1000;

for i = 1:numLog2c
    log2c = log2c_list(i);
    for j = 1:numLog2g
        log2g = log2g_list(j);
        param = ['-q -s 3 -t 2 -v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(trainScores, trainFeatures, param);
        cvMatrix(i,j) = cv;
        if (cv <= bestcv),
            bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
        end
        % fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end


%%
% Plot the results
figure;
[X,Y] = meshgrid(log2g_list,log2c_list);
contour(X,Y,cvMatrix);
xlabel('Log_2\gamma');
ylabel('Log_2c');
colormap('jet'); colorbar;


%%
% ###################################################################
% cross validation scale 2
% This is the medium scale
% ###################################################################
prevStepSize = stepSize;
stepSize = prevStepSize/2;
log2c_list = bestLog2c-prevStepSize:stepSize:bestLog2c+prevStepSize;
log2g_list = bestLog2g-prevStepSize:stepSize:bestLog2g+prevStepSize;

numLog2c = length(log2c_list);
numLog2g = length(log2g_list);
cvMatrix = zeros(numLog2c,numLog2g);
bestcv = 1000;
for i = 1:numLog2c
    log2c = log2c_list(i);
    for j = 1:numLog2g
        log2g = log2g_list(j);
        param = ['-q -s 3 -t 2 -v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(trainScores, trainFeatures, param);
        cvMatrix(i,j) = cv;
        if (cv <= bestcv),
            bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
        end
        % fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end

% ###################################################################
% cross validation scale 3
% This is the small scale
% ###################################################################
prevStepSize = stepSize;
stepSize = prevStepSize/2;
log2c_list = bestLog2c-prevStepSize:stepSize:bestLog2c+prevStepSize;
log2g_list = bestLog2g-prevStepSize:stepSize:bestLog2g+prevStepSize;

numLog2c = length(log2c_list);
numLog2g = length(log2g_list);
cvMatrix = zeros(numLog2c,numLog2g);
bestcv = 1000;
for i = 1:numLog2c
    log2c = log2c_list(i);
    for j = 1:numLog2g
        log2g = log2g_list(j);
        param = ['-q -s 3 -t 2 -v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(trainScores, trainFeatures, param);
        cvMatrix(i,j) = cv;
        if (cv <= bestcv),
            bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
        end
        % fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end
text(bestLog2g,bestLog2c,strcat('RMSE:',num2str(bestcv)));
disp(['CV : best log2c:',num2str(bestLog2c),' best log2g:',num2str(bestLog2g),' RMSE:',num2str(bestcv)]);

%%
param = ['-q -s 3 -t 2 -c ', num2str(2^bestLog2c), ' -g ', num2str(2^bestLog2g)];
bestModel = svmtrain(trainScores, trainFeatures, param);
predictedScores = svmpredict(trainScores, trainFeatures, bestModel);
[~,bestBeta] = lognonfun(predictedScores,'train',trainScores);
cd Quality_Indices
save('SVMmodel.mat','bestModel','bestLog2c','bestLog2g','bestcv','bestBeta');
