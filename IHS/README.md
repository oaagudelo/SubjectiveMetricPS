# IHS
IHS fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by exploiting the Intensity-Hue-Saturation (IHS) transformation.
 
## Interface
I_Fus_IHS = IHS(I_MS,I_PAN)

## Inputs
I_MS:           MS image upsampled at PAN scale;
I_PAN:          PAN image.

## Outputs
I_Fus_IHS:      IHS pasharpened image.
 
## References
- [Carper90]      W. Carper, T. Lillesand, and R. Kiefer, “The use of Intensity-Hue-Saturation transformations for merging SPOT panchromatic and multispectral image data,” Photogrammetric Engineering and Remote Sensing, vol. 56, no. 4, pp. 459–467, April 1990.
- [Chavez91]      P. S. Chavez Jr., S. C. Sides, and J. A. Anderson, “Comparison of three different methods to merge multiresolution and multispectral data: Landsat TM and SPOT panchromatic,” Photogrammetric Engineering and Remote Sensing, vol. 57, no. 3, pp. 295–303, March 1991.
- [Tu01]          T.-M. Tu, S.-C. Su, H.-C. Shyu, and P. S. Huang, “A new look at IHS-like image fusion methods,” Information Fusion, vol. 2, no. 3, pp. 177–186, September 2001.
- [Vivone14]      G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”, IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
