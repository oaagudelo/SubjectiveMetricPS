
# BDSD

BDSD fuses the upsampled MultiSpectral (MS) and PANchromatic (PAN) images by exploiting the Band-Dependent Spatial-Detail (BDSD) algorithm. 

## Interface
I_Fus_BDSD = BDSD(I_MS,I_PAN,ratio,S,sensor)

## Inputs
I_MS:           MS image upsampled at PAN scale;
I_PAN:          PAN image;
ratio:          Scale ratio between MS and PAN. Pre-condition: Integer value;
S:              Local estimation on SxS distinct blocks (typically 128x128); 
sensor:         String for type of sensor (e.g. 'WV2', 'IKONOS').

## Outputs
I_Fus_BDSD:     BDSD pansharpened image.
 
 ## References
- [Garzelli08]    A. Garzelli, F. Nencini, and L. Capobianco, “Optimal MMSE pan sharpening of very high resolution multispectral images,” 
                           IEEE Transactions on Geoscience and Remote Sensing, vol. 46, no. 1, pp. 228–236, January 2008.
- [Vivone14]      G. Vivone, L. Alparone, J. Chanussot, M. Dalla Mura, A. Garzelli, G. Licciardi, R. Restaino, and L. Wald, “A Critical Comparison Among Pansharpening Algorithms”, 
                           IEEE Transaction on Geoscience and Remote Sensing, 2014. (Accepted)
