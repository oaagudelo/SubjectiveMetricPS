close all;
clear all;
clc;
%% Generate Images
ratio = 4;
frame_size = 256;
K = 3;
L = 4;

ALL_MS   = zeros (frame_size,frame_size,L,K);
ALL_MS_R   = zeros (frame_size/ratio,frame_size/ratio,L,K);
ALL_PAN = zeros (frame_size*ratio,frame_size*ratio,K);
ALL_PAN_R = zeros (frame_size,frame_size,K);
frame = [[590 1100];[200 1100];[1150 380];[1450 230]];
sensor = {'IKONOS','IKONOS','IKONOS'};
for k=1:K
    %Original
    frame_x = [frame(k,1) (frame(k,1) + frame_size -1)];
    frame_y = [frame(k,2) (frame(k,2) + frame_size -1)];
    ALL_MS(:,:,:,k) = normalize(imread('Datasets/roma/bgrn.tif','PixelRegion',{frame_y,frame_x}));
    ALL_PAN(:,:,k)  = normalize(imread('Datasets/roma/pan.tif','PixelRegion',{[(frame_y(1)-1)*ratio + 1 frame_y(2)*ratio],[(frame_x(1)-1)*ratio + 1 frame_x(2)*ratio]}));
    %Reduced
    [ALL_MS_R(:,:,:,k), ALL_PAN_R(:,:,k)] = resize_images(ALL_MS(:,:,:,k),ALL_PAN(:,:,k),ratio,'IKONOS');
end
%%
% Distord Images
[ALL_MS_D, ALL_PAN_D] = DistortPrisImage(ALL_MS,ALL_PAN);
[ALL_MS_DT ,ALL_PAN_DT] = Distorted_Images(ALL_MS_D, ALL_PAN_D, ALL_MS ,ALL_PAN);

% Upsampling Images
[ALL_MS_DTU] = Upsampling( ALL_MS_DT , ratio);
[ALL_MS_U] = Upsampling( ALL_MS, ratio);
[ALL_MS_DU] = Upsampling( ALL_MS_D, ratio);
clear ALL_MS_DT ALL_MS ALL_MS_D;

% Fuse Images
[ALL_PS] = PS_Images(ALL_MS_U ,ALL_PAN, ratio, sensor);
[ALL_PS_D] = PS_Images(ALL_MS_DTU ,ALL_PAN_DT, ratio, sensor);

clear ALL_MS_DTU ALL_PAN_DT;
save('Datasets/Data_Images.mat','-v7.3','ALL_MS_U','ALL_PAN','ALL_MS_DU','ALL_PAN_D','ALL_PS','ALL_PS_D');

%% Generate Features

% Reshape Matrices
[M,N,L,K,J,Q,T,F]=size(ALL_PS_D);
ALL_MS_U = reshape(ALL_MS_U,M,N,L*K);
ALL_MS_DU = reshape(ALL_MS_DU,M,N,L*K*J*Q);
ALL_PAN_D = reshape(ALL_PAN_D,M,N,K*J*Q);
ALL_PS = reshape(ALL_PS,M,N,L*K*F);
ALL_PS_D = reshape(ALL_PS_D,M,N,L*K*J*Q*T*F);

ALL_MS_UF = Features_Group(ALL_MS_U);
clear ALL_MS_U;
ALL_PAN_F = Features_Group(ALL_PAN);
clear ALL_PAN;
ALL_MS_DUF = Features_Group(ALL_MS_DU);
clear ALL_MS_DU;
ALL_PAN_DF = Features_Group(ALL_PAN_D);
clear ALL_PAN_D;
ALL_PSF = Features_Group(ALL_PS);
clear ALL_PS;
ALL_PS_DF = Features_Group(ALL_PS_D);
clear ALL_PS_D;
ALL_F = cat(1,ALL_MS_UF,ALL_PAN_F,ALL_MS_DUF,ALL_PAN_DF,ALL_PSF,ALL_PS_DF);
save('Datasets/Data_Features.mat','-v7.3','ALL_F');

%% Organize Images Tags
Headers = {'Color','Dataset', 'Distortion', 'Level', 'Case', 'Fusion', 'Sensor' };
T_S = {'Roma 1','Roma 2','Roma 3'};
T_C = {'Blue', 'Green', 'Red', 'NIR'};
T_D = {'Blur', 'AWGN', 'RAD'};
T_L = {'Level 1','Level 2','Level 3'};
T_T = {'P_D_F', 'MS_D_F', 'PMS_D_F'};
T_F = {'BDSD','PCA', 'MTF-GLP-CBD', 'ATWT-M2'};
T_M = {'CS', 'CS','MRA','MRA'};
Tags1 = Tag_Matrix({T_C,T_S,{'N_D'},{'N_D'},{'N_D'},{'MS'},{'IKONOS'}});
Tags2 = Tag_Matrix({{'PAN'},T_S,{'N_D'},{'N_D'},{'N_D'},{'PAN'},{'IKONOS'}});
Tags3 = Tag_Matrix({T_C,T_S,T_D,T_L,{'MS_D'},{'MS'},{'IKONOS'}});
Tags4 = Tag_Matrix({{'PAN'},T_S,T_D,T_L,{'P_D'},{'PAN'},{'IKONOS'}});
Tags5 = Tag_Matrix({T_C,T_S,{'N_D'},{'N_D'},{'N_D_F'},T_F,{'IKONOS'}});
Tags6 = Tag_Matrix({T_C,T_S,T_D,T_L,T_T,T_F,{'IKONOS'}});
Tags = cat(1,Tags1,Tags2,Tags3,Tags4,Tags5,Tags6);
clear T_C T_D T_F T_L T_S T_T Tags1 Tags2 Tags3 Tags4 Tags5 Tags6;
save('Datasets/Data_Tags.mat','-v7.3','Tags','Headers');
%%
% Reshape Matrices
[M,N,L,K,J,Q,T,F]=size(ALL_PS_D);
ALL_MS_U = reshape(ALL_MS_U,M,N,L*K);
ALL_MS_DU = reshape(ALL_MS_DU,M,N,L*K*J*Q);
ALL_PAN_D = reshape(ALL_PAN_D,M,N,K*J*Q);
ALL_PS = reshape(ALL_PS,M,N,L*K*F);
ALL_PS_D = reshape(ALL_PS_D,M,N,L*K*J*Q*T*F);

ALL_MS_UF = Features1_Group(ALL_MS_U);
clear ALL_MS_U;
ALL_PAN_F = Features1_Group(ALL_PAN);
clear ALL_PAN;
ALL_MS_DUF = Features1_Group(ALL_MS_DU);
clear ALL_MS_DU;
ALL_PAN_DF = Features1_Group(ALL_PAN_D);
clear ALL_PAN_D;
ALL_PSF = Features1_Group(ALL_PS);
clear ALL_PS;
ALL_PS_DF = Features1_Group(ALL_PS_D);
clear ALL_PS_D;
ALL_F1 = cat(1,ALL_MS_UF,ALL_PAN_F,ALL_MS_DUF,ALL_PAN_DF,ALL_PSF,ALL_PS_DF);
save('Datasets/Data_Features1.mat','-v7.3','ALL_F1');

