close all;
clear all;
clc;
%% Generate Model Images
cd ..
ratio = 4;
frame_size = 256;
K1 = 6;
K2 = 6;
L = 4;
T_A = {'IKONOS'};
frame = [[590 1100];[200 1100];[1150 380];[1200 1100];[900 1250]];
k=1;
for k1=1:K1
    for k2=1:K2
        b = 1;
        frame_x = [(k1-1)*frame_size + 1 k1*frame_size];
        frame_y = [(k2-1)*frame_size + 1 k2*frame_size];
        for x=1:5
            frame_x_test = [frame(x,1) (frame(x,1) + frame_size -1)];
            frame_y_test = [frame(x,2) (frame(x,2) + frame_size -1)];
            if isRangesIntersect(frame_x,frame_x_test) && isRangesIntersect(frame_y,frame_y_test)
                b = 0;
                break;
            end
        end
        if b == 1
            ALL_MS(:,:,:,k) = normalize(imread('Datasets/roma/bgrn.tif','PixelRegion',{frame_x,frame_y}));
            ALL_PAN(:,:,k)  = normalize(imread('Datasets/roma/pan.tif','PixelRegion',{[(k1-1)*frame_size*ratio + 1 k1*frame_size*ratio],[(k2-1)*frame_size*ratio + 1 k2*frame_size*ratio]}));
            %Reduced
            [ALL_MS_R(:,:,:,k), ALL_PAN_R(:,:,k)] = resize_images(ALL_MS(:,:,:,k),ALL_PAN(:,:,k),ratio,'IKONOS');
            k=k+1;
        end
    end
end
%% Fuse Images
% Upsampling Images
ALL_MS_U = Upsampling( ALL_MS_R, ratio);
clear ALL_MS_R

% Fuse Images
ALL_PS = PS_Images(ALL_MS_U ,ALL_PAN_R, ratio, T_A);
clear ALL_MS_U ALL_PAN_R

%% Generate Model
[M,N,L,K,F]=size(ALL_PS);
ALL_PS = reshape(ALL_PS,M,N,L,K*F);
featuresModel = Features_Group(ALL_MS,'norcol+normal+color');
cd Quality_Indices
[~,pristineModel,~] = mixGaussEm(featuresModel.norcol',1);
[~,pristineModelN,~] = mixGaussEm(featuresModel.normal',1);
[~,pristineModelC,~] = mixGaussEm(featuresModel.color',1);
%%
save('pristineModel.mat','pristineModel','pristineModelN','pristineModelC');