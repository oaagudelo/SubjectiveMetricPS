close all;
clear all;
clc;
ratio = 4;
frame_size = 256;
K = 6;
L = 4;
addpath('include/');
addpath('include/C_DIIVINE');
ALL_MS   = zeros (frame_size,frame_size,L,K);
ALL_MS_R   = zeros (frame_size/ratio,frame_size/ratio,L,K);
ALL_MS_D = zeros (frame_size,frame_size,L,K,L,2,3);
ALL_MS_D_R   = zeros (frame_size/ratio,frame_size/ratio,L,K,L,2,3);
ALL_PAN = zeros (frame_size*ratio,frame_size*ratio,K);
ALL_PAN_R = zeros (frame_size,frame_size,K);
frame = [[590 1100];[200 1100];[1150 380];[1200 1100];[900 1250];[1250 400]];
T_C = {'TC','PC'};
T_S = {'Coliseum','River','Villa','Road','Urban','Test'};
T_D = {'UD','Blr', 'AWGN'};
T_L = {'UD','Level-1','Level-2','Level-3'};
T_T = {'REF','EXP','BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
T_DT = {'UD','Blue-D','Green-D','Red-D','NIR-D'};
T_A = {'IKONOS'};

for k=1:K
    %Original
    frame_x = [frame(k,1) (frame(k,1) + frame_size -1)];
    frame_y = [frame(k,2) (frame(k,2) + frame_size -1)];
    ALL_MS(:,:,:,k) = normalize(imread('Datasets/roma/bgrn.tif','PixelRegion',{frame_y,frame_x}));
    ALL_PAN(:,:,k)  = normalize(imread('Datasets/roma/pan.tif','PixelRegion',{[(frame_y(1)-1)*ratio + 1 frame_y(2)*ratio],[(frame_x(1)-1)*ratio + 1 frame_x(2)*ratio]}));
    %Reduced
    ALL_MS_D(:,:,:,k,:,:,:) = DistortPrisImageR(ALL_MS(:,:,:,k));
    [ALL_MS_R(:,:,:,k), ALL_PAN_R(:,:,k)] = resize_images(ALL_MS(:,:,:,k),ALL_PAN(:,:,k),ratio,'IKONOS');
    for l=1:L
        for j=1:2
            for t =1:3
                [ALL_MS_D_R(:,:,:,k,l,j,t), ~ ] = resize_images(ALL_MS_D(:,:,:,k,l,j,t),ALL_PAN(:,:,k),ratio,'IKONOS');
            end
        end
    end 
end
%%
% Upsampling Images
ALL_MS_D_U = Upsampling( ALL_MS_D_R, ratio);
ALL_MS_U = Upsampling( ALL_MS_R, ratio);
%ALL_MS_U_H = Upsampling( ALL_MS, ratio);
% Fuse Images
ALL_PS_D =PS_ImagesMSR(ALL_MS_D_U ,ALL_PAN_R, ratio, T_A);
ALL_PS = PS_ImagesMSR(ALL_MS_U ,ALL_PAN_R, ratio, T_A);
%ALL_PS_H = PS_ImagesR(ALL_MS_U_H ,ALL_PAN, ratio, sensor);

%% Organize Images Tags
Headers = {'Scene', 'Type','Distortion', 'Level', 'Fusion', 'Sensor' };
Tags1 = Tag_Matrix({T_S,T_DT(1),T_D(1),T_L(1),T_T(1),T_A});
Tags2 = Tag_Matrix({T_S,T_DT(1),T_D(1),T_L(1),T_T(2),T_A});
Tags3 = Tag_Matrix({T_S,T_DT(1),T_D(1),T_L(1),T_T(3:end),T_A});
Tags4 = Tag_Matrix({T_S,T_DT(2:end),T_D(2:end),T_L(2:end),T_T(3:end),T_A});
Tags = cat(1,Tags1,Tags2,Tags3,Tags4);
save('Datasets/Data_Tags.mat','-v7.3','Tags','Headers');
%%
% Reshape Matrices
[M,N,L,K,S,J,Q,F]=size(ALL_PS_D);
ALL_PS = reshape(ALL_PS,M,N,L,K*F);
ALL_PS_D = reshape(ALL_PS_D,M,N,L,K*J*Q*F*S);
%%
% ALL_PS_D_C = chroma_ms( ALL_PS_D );
% ALL_PS_C = chroma_ms( ALL_PS );
% ALL_MS_C = chroma_ms( ALL_MS );
%%
% hist_f8( ALL_PS_D_C ,ALL_PS_C, ALL_MS_C);
% hist_f9( ALL_PS_D_C ,ALL_PS_C, ALL_MS_C);
% hist_f10( ALL_PS_D_C ,ALL_PS_C, ALL_MS_C);
% hist_f11( ALL_PS_D_C ,ALL_PS_C, ALL_MS_C);
%%
ALL_MS_F = Features_Group(ALL_MS);
ALL_MS_UF = Features_Group(ALL_MS_U);
ALL_PSF = Features_Group(ALL_PS);
ALL_PS_DF = Features_Group(ALL_PS_D);
ALL_F = cat(1,ALL_MS_F,ALL_MS_UF,ALL_PSF,ALL_PS_DF);
save('Datasets/Data_Features.mat','-v7.3','ALL_F');

