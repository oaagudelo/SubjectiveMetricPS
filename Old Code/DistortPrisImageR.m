function [PAN_D] = DistortPrisImageR(PAN)
%% %%%%%%%%%%%%%%%%%%%%%%%% Distoritions %%%%%%%%%%%%%%%%%%%%%%%%%%
blr1 = fspecial('gaussian',[25 25],3);
blr2 = fspecial('gaussian',[25 25],5);
blr3 = fspecial('gaussian',[25 25],7);
        % BLUR
PAN_D(:,:,1,1)  = imfilter(PAN,blr1,'replicate');
PAN_D(:,:,1,2)  = imfilter(PAN,blr2,'replicate');
PAN_D(:,:,1,3)  = imfilter(PAN,blr3,'replicate');

% AWGN
PAN_D(:,:,2,1)  = imnoise(PAN,'gaussian',0,0.0500^2);
PAN_D(:,:,2,2)  = imnoise(PAN,'gaussian',0,0.1000^2);
PAN_D(:,:,2,3)  = imnoise(PAN,'gaussian',0,0.1500^2);

end

