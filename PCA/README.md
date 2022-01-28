# PCA 

PCA fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by exploiting the Principal Component Analysis (PCA) transformation. 

## Interface

I_Fus_PCA = PCA(I_MS,I_PAN)

## Inputs
           
I_MS:           MS image upsampled at PAN scale;
I_PAN:          PAN image.

## Outputs
           
I_Fus_PCA:      PCA pansharpened image.
 
## References
- [Chavez89]      P. S. Chavez Jr. and A. W. Kwarteng, “Extracting spectral contrast in Landsat Thematic Mapper image data using selective principal component analysis,” Photogrammetric Engineering and Remote Sensing, vol. 55, no. 3, pp. 339–348, March 1989.
- [Vivone14]      G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”, IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
