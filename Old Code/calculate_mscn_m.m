function mscn = calculate_mscn_m(im)
% MSCN = calculate_mscn(IM)
% calculates the mean substracted contrast normalized coefficients (MSCN)
% of image IM.
[~,~,L]=size(im);
for l=1:L
    window        = fspecial('gaussian',7,7/6);
    mu            = imfilter(im(:,:,l),window,'replicate');
    mu_sq         = mu.*mu;
    sigma         = sqrt(abs(imfilter(im(:,:,l).*im(:,:,l),window,'replicate') - mu_sq));
    mscn          = (im(:,:,l)-mu)./(sigma+1);
end
end