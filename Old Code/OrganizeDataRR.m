close all;
clear all;
clc;
%%
ratio = 4;
frame_size = 256;
K = 6;
L = 4;
P = 4;
addpath('include/');
addpath('include/C_DIIVINE');
ALL_MS   = zeros (frame_size,frame_size,L,K*K);
ALL_MS_D = zeros (frame_size,frame_size,L,K*K,3,3);
ALL_MS_R   = zeros (frame_size/ratio,frame_size/ratio,L,K*K);
ALL_MS_D_R = zeros (frame_size/ratio,frame_size/ratio,L,K*K,3,3);
ALL_PAN = zeros (frame_size*ratio,frame_size*ratio,K*K);
ALL_PAN_D = zeros (frame_size*ratio,frame_size*ratio,K*K,3,3);
ALL_PAN_R = zeros (frame_size,frame_size,K*K);
ALL_PAN_D_R = zeros (frame_size,frame_size,K*K,3,3);
T_C = {'TC','PC'};
T_S = {};
T_D = {'UD','Blr', 'AWGN','RAD'};
T_L = {'UD','Level-1','Level-2','Level-3'};
T_T = {'UD','P_D', 'MS_D', 'PMS_D'};
T_F = {'REF','EXP','BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
T_A = {'IKONOS'};
for k1=1:K
    for k2=1:K
    T_S = [T_S num2str(K*(k1-1)+k2)];
    ALL_MS(:,:,:,K*(k1-1)+k2) = normalize(imread('Datasets/roma/bgrn.tif','PixelRegion',{[(k1-1)*frame_size + 1 k1*frame_size],[(k2-1)*frame_size + 1 k2*frame_size]}));
    ALL_PAN(:,:,K*(k1-1)+k2)  = normalize(imread('Datasets/roma/pan.tif','PixelRegion',{[(k1-1)*frame_size*ratio + 1 k1*frame_size*ratio],[(k2-1)*frame_size*ratio + 1 k2*frame_size*ratio]}));
    %Reduced
    [ALL_MS_R(:,:,:,K*(k1-1)+k2), ALL_PAN_R(:,:,K*(k1-1)+k2)] = resize_images(ALL_MS(:,:,:,K*(k1-1)+k2),ALL_PAN(:,:,K*(k1-1)+k2),ratio,'IKONOS');
    [ALL_MS_D_R(:,:,:,K*(k1-1)+k2,:,:), ALL_PAN_D_R(:,:,K*(k1-1)+k2,:,:)] = DistortPrisImageRR(ALL_MS_R(:,:,:,K*(k1-1)+k2),ALL_PAN_R(:,:,K*(k1-1)+k2));
    end
end
%%
% Upsampling Images
ALL_MS_U = Upsampling( ALL_MS_R, ratio);
ALL_MS_D_U = Upsampling( ALL_MS_D_R, ratio);
%ALL_MS_U_H = Upsampling( ALL_MS, ratio);
[ALL_MS_D_U_T ,ALL_PAN_D_R_T] = Distorted_Images(ALL_MS_D_U ,ALL_PAN_D_R, ALL_MS_U, ALL_PAN_R);
% Fuse Images
ALL_PS_D =PS_ImagesRR(ALL_MS_D_U_T ,ALL_PAN_D_R_T, ratio, T_A);
ALL_PS = PS_ImagesRR(ALL_MS_U ,ALL_PAN_R, ratio, T_A);
%ALL_PS_H = PS_ImagesR(ALL_MS_U_H ,ALL_PAN, ratio, sensor);

%% Organize Images Tags
Headers = {'Scene', 'Distortion', 'Level','Type', 'Fusion','Sensor' };
Tag_REF = Tag_Matrix({T_S,T_D(1),T_L(1),T_T(1),T_F(1),T_A});
Tag_EXP = Tag_Matrix({T_S,T_D(1),T_L(1),T_T(1),T_F(2),T_A});
Tag_PS  = Tag_Matrix({T_S,T_D(1),T_L(1),T_T(1),T_F(3:end),T_A});
Tag_PSD = Tag_Matrix({T_S,T_D(2:end),T_L(2:end),T_T(2:end),T_F(3:end),T_A});
Tags = cat(1,Tag_REF,Tag_EXP,Tag_PS,Tag_PSD);
clear Tag_REF Tag_EXP Tag_PS Tag_PSD
save('Datasets/Data_Tags.mat','-v7.3','Tags','Headers');
%%
% Reshape Matrices
[M,N,L,K,J,Q,T,F]=size(ALL_PS_D);
ALL_PS = reshape(ALL_PS,M,N,L,K*F);
ALL_PS_D = reshape(ALL_PS_D,M,N,L,K*J*Q*T*F);
ALL_IM = cat(4,ALL_MS,ALL_MS_U,ALL_PS,ALL_PS_D);

%%
ALL_IM_F = Features_Group(ALL_IM,'normal','complete');
%%
save('Datasets/Data_Features.mat','-v7.3','ALL_IM_F');
