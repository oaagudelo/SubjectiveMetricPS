function [ output_args ] = Qsvm( input_args )
[trainFeatures, testFeatures, ~] = scaleSVM(trainFeatures, testFeatures, trainFeatures, 0, 1);
param = ['-q -s 3 -t 2 -c ', num2str(2^bestLog2c), ' -g ', num2str(2^bestLog2g)];
Model = svmtrain(trainScores, trainFeatures, param);
predictedScores = svmpredict(0, testFeatures, Model);
logmetric = lognonfun(predictedScores,'fun',metricbeta(:,10));
R(10,1,i) = abs(corr(logmetric,testScores,'Type','Spearman'));
R(10,2,i) = abs(corr(logmetric,testScores,'Type','Pearson'));
R(10,3,i) = sqrt(mean((logmetric-testScores).^2));


end

