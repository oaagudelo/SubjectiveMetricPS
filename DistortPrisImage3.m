function [ I_MS_D, I_PAN_D] = DistortPrisImage3(I_MS,I_PAN)
%% %%%%%%%%%%%%%%%%%%%%%%%% Distoritions %%%%%%%%%%%%%%%%%%%%%%%%%%
for dl=1:3
    for l = 1:4
        % BLUR
        I_MS_D(:,:,l,1,dl) = normalize(imfilter(I_MS(:,:,l),fspecial('gaussian',[25 25],3+(dl-1)*2),'replicate'));
        % AWGN
        I_MS_D(:,:,l,2,dl) = normalize(imnoise(I_MS(:,:,l),'gaussian',((dl/20))^2));
        % RAD
        I_MS_D(:,:,l,3,dl) = normalize(round(I_MS(:,:,l)*((2^(8-dl*2))-1)));
    end
    % BLUR
    I_PAN_D(:,:,1,dl)  = normalize(imfilter(I_PAN(:,:),fspecial('gaussian',[25 25],3+(dl-1)*2),'replicate'));
    % AWGN
    I_PAN_D(:,:,2,dl)  = normalize(imnoise(I_PAN(:,:),'gaussian',0,((dl/20))^2));
    % RAD
    I_PAN_D(:,:,3,dl)  = normalize(round(I_PAN(:,:)*((2^(8-dl*2))-1)));
end

end

