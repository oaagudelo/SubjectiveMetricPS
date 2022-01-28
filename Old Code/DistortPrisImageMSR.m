function [I_MS_D] = DistortPrisImageMSR(I_MS)
%% %%%%%%%%%%%%%%%%%%%%%%%% Distoritions %%%%%%%%%%%%%%%%%%%%%%%%%%
blr1 = fspecial('gaussian',[25 25],3);
blr2 = fspecial('gaussian',[25 25],5);
blr3 = fspecial('gaussian',[25 25],7);
[~,~,L,K] = size(I_MS);
I_MS_D = repmat(I_MS,[1,1,1,1,L,2,3]);
for k = 1:K
    for l = 1:L
        % BLUR
        I_MS_D(:,:,l,k,l,1,1)  = imfilter(I_MS(:,:,l,k),blr1,'replicate');
        I_MS_D(:,:,l,k,l,1,2)  = imfilter(I_MS(:,:,l,k),blr2,'replicate');
        I_MS_D(:,:,l,k,l,1,3)  = imfilter(I_MS(:,:,l,k),blr3,'replicate');

        % AWGN
        I_MS_D(:,:,l,k,l,2,1)  = imnoise(I_MS(:,:,l,k),'gaussian',0,0.0500^2);
        I_MS_D(:,:,l,k,l,2,2)  = imnoise(I_MS(:,:,l,k),'gaussian',0,0.1000^2);
        I_MS_D(:,:,l,k,l,2,3)  = imnoise(I_MS(:,:,l,k),'gaussian',0,0.1500^2);
    end
end
end

