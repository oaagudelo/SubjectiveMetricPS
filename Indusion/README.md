# Indusion

Indusion fuses the MultiSpectral (MS) and PANchromatic (PAN) images by exploiting the Indusion algorithm. 
 
## Interface

I_Fus_Indusion = Indusion(I_PAN,I_MS_LR,ratio)

## Inputs
 
I_PAN:          PAN image;
I_MS_LR:        MS image;
ratio:          Scale ratio between MS and PAN. Pre-condition: Integer value.

## Outputs

I_Fus_Indusion: Indusion pansharpened image.
 
## References
- [Khan08]        M. M. Khan, J. Chanussot, L. Condat, and A. Montavert, “Indusion: Fusion of multispectral and panchromatic images using the induction scaling technique,” IEEE Geoscience and Remote Sensing Letters, vol. 5, no. 1, pp. 98–102, January 2008.
- [Vivone14]      G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”, IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
