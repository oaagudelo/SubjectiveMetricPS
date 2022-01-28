# PRACS

PRACS fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by exploiting the Partial Replacement Adaptive CS (PRACS) algorithm. 
 
## Interface

I_Fus_PRACS = PRACS(I_MS,I_PAN,ratio)

## Inputs

I_MS:           MS image upsampled at PAN scale;
I_PAN:          PAN image;
ratio:          Scale ratio between MS and PAN. Pre-condition: Integer value.

## Outputs

I_Fus_PRACS:    PRACS pansharpened image.
 
## References:
- [Choi11]        J. Choi, K. Yu, and Y. Kim, “A new adaptive component-substitution-based satellite image fusion by using partial replacement,” IEEE Transactions on Geoscience and Remote Sensing, vol. 49, no. 1, pp. 295–309, January 2011.
- [Vivone14]      G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”,  IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
