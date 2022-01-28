%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           Normalization. 
% 
% Interface:
%          	ImageToNormalize = linstretch(ImageToNormalize)
%
% Inputs:
%           ImageToNormalize:    Image to Normalize;
%
% Outputs:
%           NormalizedImage:    Normalized image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ImageNormalized = normalize(ImageToNormalize)
[M,N,C] = size(ImageToNormalize);
ImageNormalized = zeros(M,N,C);
NM = N*M;
for i=1:C
b = double(reshape(ImageToNormalize(:,:,i),NM,1));
t(1)=min(b);
t(2)=max(b);
b = (b-t(1))./(t(2)-t(1));
ImageNormalized(:,:,i) = reshape(b,M,N);
end
end