function mscn = calculate_mscn(im)
% MSCN = calculate_mscn(IM)
% calculates the mean substracted contrast normalized coefficients (MSCN)
% of image IM.
 window        = fspecial('gaussian',7,7/6);
 window        = window/sum(sum(window));
 mu            = imfilter(im,window,'replicate');
 mu_sq         = mu.*mu;
 sigma         = sqrt(abs(imfilter(im.*im,window,'replicate') - mu_sq));
 mscn          = (im-mu)./(sigma+1);
 end