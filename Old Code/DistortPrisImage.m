function [ I_MS_D, I_PAN_D, T_D, T_L] = DistortPrisImage(I_MS,I_PAN)
%% %%%%%%%%%%%%%%%%%%%%%%%% Distoritions %%%%%%%%%%%%%%%%%%%%%%%%%%
blr1 = fspecial('gaussian',[15 15],1);
blr2 = fspecial('gaussian',[15 15],2);
blr3 = fspecial('gaussian',[15 15],3);
[M,N,L,K] = size(I_MS); 
I_MS_D = zeros(M,N,L,K,3,3);
[M,N,K] = size(I_PAN);
I_PAN_D = zeros(M,N,K,3,3);
T_D = {'Blur', 'AWGN', 'RAD'};
T_L = {'Level 1','Level 2','Level 3'};
for k = 1:K
    for l = 1:L
        % BLUR
        I_MS_D(:,:,l,k,1,1) = imfilter(I_MS(:,:,l,k),blr1,'replicate');
        I_MS_D(:,:,l,k,1,2) = imfilter(I_MS(:,:,l,k),blr2,'replicate');
        I_MS_D(:,:,l,k,1,3) = imfilter(I_MS(:,:,l,k),blr3,'replicate');

        % AWGN
        I_MS_D(:,:,l,k,2,1) = imnoise(I_MS(:,:,l,k),'gaussian',0,0.00250^2);
        I_MS_D(:,:,l,k,2,2) = imnoise(I_MS(:,:,l,k),'gaussian',0,0.01375^2);
        I_MS_D(:,:,l,k,2,3) = imnoise(I_MS(:,:,l,k),'gaussian',0,0.02500^2);

        % RAD
        I_MS_D(:,:,l,k,3,1) = normalize(round(I_MS(:,:,l,k)*((2^5)-1)));
        I_MS_D(:,:,l,k,3,2) = normalize(round(I_MS(:,:,l,k)*((2^4)-1)));
        I_MS_D(:,:,l,k,3,3) = normalize(round(I_MS(:,:,l,k)*((2^3)-1)));
    end

    % BLUR
    I_PAN_D(:,:,k,1,1)  = imfilter(I_PAN(:,:,k),blr1,'replicate');
    I_PAN_D(:,:,k,1,2)  = imfilter(I_PAN(:,:,k),blr2,'replicate');
    I_PAN_D(:,:,k,1,3)  = imfilter(I_PAN(:,:,k),blr3,'replicate');

    % AWGN
    I_PAN_D(:,:,k,2,1)  = imnoise(I_PAN(:,:,k),'gaussian',0,0.00250^2);
    I_PAN_D(:,:,k,2,2)  = imnoise(I_PAN(:,:,k),'gaussian',0,0.01375^2);
    I_PAN_D(:,:,k,2,3)  = imnoise(I_PAN(:,:,k),'gaussian',0,0.02500^2);

    % RAD
    I_PAN_D(:,:,k,3,1)  = normalize(round(I_PAN(:,:,k)*((2^5)-1)));
    I_PAN_D(:,:,k,3,2)  = normalize(round(I_PAN(:,:,k)*((2^4)-1)));
    I_PAN_D(:,:,k,3,3)  = normalize(round(I_PAN(:,:,k)*((2^3)-1)));
end
end

