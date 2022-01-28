close all;
clear all;
clc;
%%
ratio = 4;
frame_size = 256;
K = 6;
L = 4;
T_C = {'TC','PC'};
T_S = {};
T_D = {'UD','Blr', 'AWGN','RAD'};
T_L = {'UD','Level-1','Level-2','Level-3'};
T_T = {'UD','PD', 'MSD', 'PMSD'};
T_F = {'REF','EXP','BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
T_A = {'IKONOS'};
for k1=1:K
    for k2=1:K
        k = K*(k1-1)+k2;
        T_S = [T_S num2str(k)];
        ALL_MS(:,:,:,k) = normalize(imread('Datasets/roma/bgrn.tif','PixelRegion',{[(k1-1)*frame_size + 1 k1*frame_size],[(k2-1)*frame_size + 1 k2*frame_size]}));
        ALL_PAN(:,:,k)  = normalize(imread('Datasets/roma/pan.tif','PixelRegion',{[(k1-1)*frame_size*ratio + 1 k1*frame_size*ratio],[(k2-1)*frame_size*ratio + 1 k2*frame_size*ratio]}));
        %Reduced
        [ALL_MS_D, ALL_PAN_D] = DistortPrisImage3(ALL_MS(:,:,:,K*(k1-1)+k2),ALL_PAN(:,:,K*(k1-1)+k2));
        [ALL_MS_D_T(:,:,:,k,:,:,:) ,ALL_PAN_D_T] = Distorted_Images(ALL_MS_D ,ALL_PAN_D, ALL_MS(:,:,:,k), ALL_PAN(:,:,k));
        [~,~,~,~,J,Q,T]=size(ALL_MS_D_T);
        for j=1:J
            for q=1:Q
                for t=1:T
                    [ALL_MS_D_T_R(:,:,:,k,j,q,t), ALL_PAN_D_T_R(:,:,k,j,q,t)] = resize_images(ALL_MS_D_T(:,:,:,k,j,q,t),ALL_PAN_D_T(:,:,j,q,t),ratio,'IKONOS');
                end
            end
        end
        [ALL_MS_R(:,:,:,k), ALL_PAN_R(:,:,k)] = resize_images(ALL_MS(:,:,:,k),ALL_PAN(:,:,k),ratio,'IKONOS');
    end
end
%%
% Upsampling Images
ALL_MS_U = Upsampling(ALL_MS_R,ratio);
ALL_MS_D_T_U = Upsampling(ALL_MS_D_T_R,ratio);
% Fuse Images
ALL_PS = PS_Images(ALL_MS_U ,ALL_PAN_R, ratio, T_A);
ALL_PS_D = PS_Images(ALL_MS_D_T_U ,ALL_PAN_D_T_R, ratio, T_A);
save('Outputs/ScatterFeatures/ImagesFeatures.mat','-v7.3','ALL_PS_D','ALL_PS','ALL_MS_U','ALL_MS');
%% Organize Images Tags
Headers = {'Scene', 'Distortion', 'Level','Type', 'Fusion','Sensor' };
Tag_PSD = Tag_Matrix({T_S,T_D(2:end),T_L(2:end),T_T(2:end),T_F(3:end),T_A});
Tag_PS  = Tag_Matrix({T_S,T_D(1),T_L(1),T_T(1),T_F(3:end),T_A});
Tag_EXP = Tag_Matrix({T_S,T_D(1),T_L(1),T_T(1),T_F(2),T_A});
Tag_REF = Tag_Matrix({T_S,T_D(1),T_L(1),T_T(1),T_F(1),T_A});
Tags = cat(1,Tag_PSD,Tag_PS,Tag_EXP,Tag_REF);
clear Tag_REF Tag_EXP Tag_PS Tag_PSD
save('Outputs/ScatterFeatures/Data_Tags.mat','-v7.3','Tags','Headers');