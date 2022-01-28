function F = Features_GroupMS( I )
[~,~,~,K]=size(I);

for k = 1:K
    GoodallFeats = computeGoodallFeaturesMS(I(:,:,:,k),'f');
    F(k,:) = GoodallFeats';
end
end

