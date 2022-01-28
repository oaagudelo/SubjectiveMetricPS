function score_NIQE=Q_NIQE(fused,pristineModel)
%INPUTS: 
%fused: MS image with size MxNx4
% PristineModel: structure with fields sigma (covariance matrix)
% and mu (mean).sigma and mean were extracted fitted with a MVG made of 100
% images (80 MS and 20 PAN)

blocksizerow    = 64;
blocksizecol    = 64;
blockrowoverlap = 0;
blockcoloverlap = 0;
sh_th=0.3;

% Get the Covariance matrix and Mean vector 
cov_prisparam = pristineModel.sigma;
mu_prisparam = pristineModel.mu;

feats =computefeaturesNIQE(fused,blocksizerow,blocksizecol,...
    blockrowoverlap,blockcoloverlap,mu_prisparam,cov_prisparam)

% Dependencies:
% - To compute steerable pyramid coefficients: matlabPyrTools.
%   Available: http://www.cns.nyu.edu/lcv/software.php
% - To compute MVG model: EmGm.
%   Available: http://www.mathworks.com/matlabcentral/fileexchange/26184-em-algorithm-for-gaussian-mixture-model--em-gmm-
%
% Input:
% fused            = fused image whose quality needs to be computed (MxNx4)
% pristineModel    = MVG NSS-feature model
% group (optional) = groups of NSS-features to be computed from the
% fused image, by default it computes all NSS-features. Note: the number of
% features must be the same as the pristine model's
% 
% Output:
% res              = quality of input fused image. Higher values indicate
% worse quality.

% Take default group of features



% compute image features

%features = Features_Group( fused ,m);
% get model of fused image
for k=1:size(fused,3)
    
%[~,model,~] = mixGaussEm(struct2array(features)',1);
[~,model,~] = mixGaussEm(feats{k}',1);

cov = model.Sigma;
mu = model.mu;

% calculate Mahalanobis distance
invcov_param = pinv((cov_prisparam + cov)/2);
res(k) = sqrt((mu_prisparam - mu')*invcov_param*(mu_prisparam' - mu));

end

score_NIQE=mean(res);
end


