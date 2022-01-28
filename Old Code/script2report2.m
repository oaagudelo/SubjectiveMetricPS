close all;
clear all;
clc;
%%
load('Datasets/Data_Tags.mat');
load('Datasets/Data_Features.mat');
%%
Scatter_Features(ALL_F,Tags,Headers,4,7,'','P');
%Scatter_Features(ALL_F,Tags,Headers,4,3,'N_D');

%% PS Images
close all;
clear all;
clc;
load('Datasets/Data_Images.mat')
%%
% True Color
viewimage(uint16((2^16)*ALL_PS(:,:,1:3,1,1)));
print('Outputs/Image_Pri.png','-dpng');
close
viewimage(uint16((2^16)*ALL_PS_D(:,:,1:3,1,1,3,1,1)));
print('Outputs/Image_Blur.png','-dpng');
close
viewimage(uint16((2^16)*ALL_PS_D(:,:,1:3,1,2,3,1,1)));
print('Outputs/Image_AWGN.png','-dpng');
close
viewimage(uint16((2^16)*ALL_PS_D(:,:,1:3,1,3,3,1,1)));
print('Outputs/Image_RAD.png','-dpng');
close
% Pseudocolor
viewimage(uint16((2^16)*ALL_PS(:,:,2:4,1,1)));
print('Outputs/Image_Pri_p.png','-dpng');
close
viewimage(uint16((2^16)*ALL_PS_D(:,:,2:4,1,1,3,1,1)));
print('Outputs/Image_Blur_p.png','-dpng');
close
viewimage(uint16((2^16)*ALL_PS_D(:,:,2:4,1,2,3,1,1)));
print('Outputs/Image_AWGN_p.png','-dpng');
close
viewimage(uint16((2^16)*ALL_PS_D(:,:,2:4,1,3,3,1,1)));
print('Outputs/Image_RAD_p.png','-dpng');
close
%%
L = 3;
D = 3;
F = 4;
sensor = 'IKONOS';
ratio = 4;
Q_index = zeros(D,L,3,3);
D_lambda_index = zeros(D,L,3,3);
D_s_index = zeros(D,L,3,3);
for im=1:3
%for d=1:D
    %for l=1:L 
        for f=1:F
        %cd Quality_Indices
        %[Q_index(d,l,1,im),D_lambda_index(d,l,1,im),D_s_index(d,l,1,im)] = QNR(ALL_PS_D(:,:,:,im,d,l,1,2),ALL_MS(:,:,:,im),ALL_PAN(:,:,im),sensor,ratio,'normal');
        %[Q_index(d,l,2,im),D_lambda_index(d,l,2,im),D_s_index(d,l,2,im)] = QNR(ALL_PS_D(:,:,:,im,d,l,1,2),ALL_MS(:,:,:,im),ALL_PAN(:,:,im),sensor,ratio,'mscn_bd');
        %[Q_index(d,l,3,im),D_lambda_index(d,l,2,im),D_s_index(d,l,3,im)] = QNR(ALL_PS_D(:,:,:,im,d,l,1,2),ALL_MS(:,:,:,im),ALL_PAN(:,:,im),sensor,ratio,'mscn_bc');
        [Q_avg_EXP, SAM_EXP, ERGAS_EXP, SCC_GT_EXP, Q_EXP, QNR, QNRb] = indexes_evaluation(ALL_PS(:,:,:,im,f),ALL_MS(:,:,:,im),ALL_MS_R(:,:,:,im),ALL_PAN_R(:,:,im),'IKONOS',ratio,11,32,0,0,0);
        %[Q_avg_EXP, SAM_EXP, ERGAS_EXP, SCC_GT_EXP, Q_EXP, QNR, QNRb] = indexes_evaluation(ALL_PS_D(:,:,:,im,d,l,1,f),ALL_MS(:,:,:,im),ALL_MS_R(:,:,:,im),ALL_PAN_R(:,:,im),'IKONOS',ratio,11,32,0,0,0);
        MatrixResults(im,f,:) = [Q_EXP,Q_avg_EXP,SAM_EXP,ERGAS_EXP,SCC_GT_EXP, QNR, QNRb];
        disp(strcat(num2str(((D*(d-1)+l)/9)*100),'%'))
        %cd ..
        %viewimage(uint16((2^16)*ALL_PS_D(:,:,:,1,d,l,1,1)));
        %end
    %end
end
end
%%
for im=1:3
plot(QNR_index(:,:,1,im)','-*')
hold on
ax = gca;
ax.ColorOrderIndex = 1;
plot(QNR_index(:,:,2,im)','--s')
hold on
ax = gca;
ax.ColorOrderIndex = 1;
plot(QNR_index(:,:,3,im)','-.d')
legend('Blur QNR','AWGN QNR','RAD QNR','Blur QNR*','AWGN QNR*','RAD QNR*','Blur QNR**','AWGN QNR**','RAD QNR**','location','best')
figure;
end
%% Spectral
for im=1:1
for i=1:3
x(:,:,i) = reshape(calculate_mscn(normalize(ALL_PS_D(:,:,:,im,1,i,1,1))),1024*1024,4);
end
y = reshape(calculate_mscn(normalize(ALL_MS(:,:,:,im))),256*256,4);
N = - 0.2:0.001:0.2;
ind = 1;
for j=1:3
    for k=j+1:4
        for i =1:3
            X1 = hist(x(:,j,i),N);
            X2 = hist(x(:,k,i),N);
            Y1 = hist(y(:,j),N);
            Y2 = hist(y(:,k),N);
            %bd(ind,i) = abs(sum(sqrt((X1/sum(X1)).*(X2/sum(X2))))-sum(sqrt((Y1/sum(Y1)).*(Y2/sum(Y2)))));
            %bd(ind,i) = abs(bhattacharyya(x(:,j,i),x(:,k,i)) - bhattacharyya(y(:,j),y(:,k)));
            %bd(ind,i) = abs(uqi(ALL_PS_D(:,:,j,im,1,i,1,1),ALL_PS_D(:,:,k,im,1,i,1,1)) - uqi(ALL_MS(:,:,j,im),ALL_MS(:,:,k,im)));
            %bd(ind,i) = abs(feature_distance(ALL_PS_D(:,:,j,im,1,i,1,1),ALL_PS_D(:,:,k,im,1,i,1,1)) - feature_distance(ALL_MS(:,:,j,im),ALL_MS(:,:,k,im)));
        end
        ind = ind + 1;
    end
end
figure;
plot(bd','-*')
hold off
legend('B G','B R','B N','G R','G N','R N','location','best')

end

%% Spatial

for i=1:3
x(:,:,i) = reshape(calculate_mscn(normalize(ALL_PS_D(:,:,:,1,1,i,2,1))),1024*1024,4);
end
y = reshape(calculate_mscn(normalize(ALL_MS(:,:,:,1))),256*256,4);
z = reshape(calculate_mscn(normalize(ALL_PAN(:,:,1))),1024*1024,1);
ind = 1;
for j=1:4
    for i =1:3
        X = hist(x(:,j,i),N);
        Y = hist(y(:,j),N);
        Z = hist(z,N);
        %bd(ind,i) = abs(sum(sqrt((X/sum(X)).*(Z/sum(Z))))-sum(sqrt((Y/sum(Y)).*(Z/sum(Z)))));
        bd(ind,i) = abs(bhattacharyya(x(:,j,i),z) - bhattacharyya(y(:,j),z));
    end
    ind = ind + 1;
end

plot(bd','-*')
hold on 
legend('B P','G P','R P','N P','location','best')


%%
n1 = ALL_PS(:,:,1,1,1);
x1 = ALL_PS_D(:,:,1,1,1,3,1,1);
y1 = ALL_PS_D(:,:,1,1,2,3,1,1);
z1 = ALL_PS_D(:,:,1,1,3,3,1,1);
x2 = ALL_MS(:,:,1,1);
y2 = ALL_MS(:,:,2,1);
N = - 0.2:0.001:0.2;
nd1 = calculate_mscn(normalize(n1));
xd1 = calculate_mscn(normalize(x1));
yd1 = calculate_mscn(normalize(y1));
zd1 = calculate_mscn(normalize(z1));
Nd1 = hist(nd1(:),N);
Xd1 = hist(xd1(:),N);
Yd1 = hist(yd1(:),N);
Zd1 = hist(zd1(:),N);
xd2 = calculate_mscn(normalize(x2));
yd2 = calculate_mscn(normalize(y2));
Xd2 = hist(xd2(:),N);
Yd2 = hist(yd2(:),N);
plot(N,Nd1/sum(Nd1))
hold on
plot(N,Xd1/sum(Xd1))
hold on
plot(N,Yd1/sum(Yd1))
hold on
plot(N,Zd1/sum(Zd1))
legend('Pristine','Blur', 'AWGN', 'RAD','location','best')
% d1 = sum(sqrt((Xd1/sum(Xd1)).*(Yd1/sum(Yd1))));
% d2 = sum(sqrt((Xd2/sum(Xd2)).*(Yd2/sum(Yd2))));
% abs(d1-d2)

%%
N = - 0.2:0.001:0.2;
L = 3;
D = 3;
t ={'Level 1','Level 2', 'Level 3'};
j ={'Blur ','AWGN ', 'RAD '};

for d=1:D
    for l=1:L
        figure;
        for b=1:1 
            H1 = hist(reshape(calculate_mscn(normalize(ALL_PS_D(:,:,b,1,d,l,1,1))),1024^2,1),N);
            plot(N,H1/sum(H1),'-*')
            hold on
            H2 = hist(reshape(calculate_mscn(normalize(ALL_PAN(:,:,1))),1024^2,1),N);
            plot(N,H2/sum(H2),'-d')
            hold on
            r(d,l) = sum(sqrt((H1/sum(H1)).*(H2/sum(H2))));
            e(d,l) = bhattacharyya(reshape(calculate_mscn(normalize(ALL_PS_D(:,:,b,1,d,l,1,1))),1024^2,1),reshape(calculate_mscn(normalize(ALL_PAN(:,:,1))),1024^2,1));
        end
        axis([-0.05 0.05 0 0.2])
        legend('Blue PS','PAN','location','best')
        title(strcat(j{d},t{l}))
    end
end
%%
load('Datasets/Data_Tags.mat');
load('Datasets/Data_Features1.mat');
Scatter_Features(ALL_F1(strcmp(Tags(:,5),'P_D_F'),:),Tags(strcmp(Tags(:,5),'P_D_F'),:),Headers,4,7,'','np');
