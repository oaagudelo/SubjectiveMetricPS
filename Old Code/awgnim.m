%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           AWGN. 
% 
% Interface:
%          	ImageAWGN = awgnim(ImageToAWGN,vari)
%
% Inputs:
%           ImageToAWGN:    Image to distort with AWGN;
%
% Outputs:
%           ImageAWGN:    Distorted AWGN image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ImageToAWGN = awgnim(ImageToAWGN,desv)
[N,M,C] = size(ImageToAWGN);
NM = N*M;
for i=1:C
b = reshape(ImageToAWGN(:,:,i),NM,1);
SNR = 10 * log10(var(b)/(desv^2));
b = awgn(b,SNR);
ImageToAWGN(:,:,i) = reshape(b,N,M);
end
end