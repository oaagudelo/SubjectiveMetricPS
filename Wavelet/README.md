# ATWT

ATWT fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by exploiting the A Trous Wavelet Transform (ATWT) and additive injection model algorithm.
 
## Interface

I_Fus_ATWT = ATWT(I_MS,I_PAN,ratio)

## Inputs

I_MS:           MS image upsampled at PAN scale;
I_PAN:          PAN image;
ratio:          Scale ratio between MS and PAN. Pre-condition: Integer value.

## Outputs

I_Fus_ATWT:     ATWT pasharpened image.
 
## References

- [Nunez99]       J. Nunez, X. Otazu, O. Fors, A. Prades, V. Pala, and R. Arbiol, “Multiresolution-based image fusion with additive wavelet decomposition,” IEEE Transactions on Geoscience and Remote Sensing, vol. 37, no. 3, pp. 1204–1211, May 1999.
- [Vivone14a]     G. Vivone, R. Restaino, M. Dalla Mura, G. Licciardi, and J. Chanussot, “Contrast and error-based fusion schemes for multispectral image pansharpening,” IEEE Geoscience and Remote Sensing Letters, vol. 11, no. 5, pp. 930–934, May 2014.
- [Vivone14b]     G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”,  IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
