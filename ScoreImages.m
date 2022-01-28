close all;
clear all;
clc;
%% Generate Test Images
ratio = 4;
frame_size = 256;
addpath('include/');    
addpath('include/C_DIIVINE');
T_A = {'IKONOS'};
frame = [[590 1100];[200 1100];[1150 380];[1200 1100];[900 1250];[1250 400]];
for k=1:5
    frame_x = [frame(k,1) (frame(k,1) + frame_size -1)];
    frame_y = [frame(k,2) (frame(k,2) + frame_size -1)];
    ALL_MS(:,:,:,k) = normalize(imread('Datasets/roma/bgrn.tif','PixelRegion',{frame_y,frame_x}));
    ALL_PAN(:,:,k)  = normalize(imread('Datasets/roma/pan.tif','PixelRegion',{[(frame_y(1)-1)*ratio + 1 frame_y(2)*ratio],[(frame_x(1)-1)*ratio + 1 frame_x(2)*ratio]}));
    %Reduced
    [ ALL_MS_D, ALL_PAN_D] = DistortPrisImage3(ALL_MS(:,:,:,k),ALL_PAN(:,:,k));
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

%%
% Fuse Images
ALL_MS_U = Upsampling(ALL_MS_R,ratio);
ALL_MS_D_T_U = Upsampling(ALL_MS_D_T_R,ratio);
ALL_PS = PS_Images(ALL_MS_U ,ALL_PAN_R, ratio, T_A);
ALL_PS_D = PS_Images(ALL_MS_D_T_U ,ALL_PAN_D_T_R, ratio, T_A);
save('Outputs/Metrics/ScoreImages.mat','-v7.3','ALL_MS','ALL_MS_D_T','ALL_PS_D','ALL_PS','ALL_MS_U','ALL_MS_R','ALL_PAN_R','ALL_PAN_D_T_R','ALL_MS_D_T_R');
