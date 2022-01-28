clc;
clear all;
close all;
%%
load('Outputs/Curves/Curves.mat');
%%
[~,~,J,F,T] = size(m);
load('Outputs/Histograms.mat');
T_D = {'Blr', 'AWGN','RAD'};
T_T = {'P-D', 'MS-D', 'PMS-D'};
T_F = {'BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
for dl=1:7
    x(dl,1) = 1+dl;
    x(dl,2) = dl/40;
    x(dl,3) = 8-dl;
end
%%
j_tag={'Standar deviation','Standar deviation','Quantization bits'};

for t=1:T
    for f=1:F
        for j=1:J
            plot(x(:,j),m(:,:,j,f,t));
            set(gca,'FontSize',12);
            axis([min(x(:,j)) max(x(:,j)) 0 inf])
            axis square
            xlabel(j_tag{j},'FontSize',15)
            ylabel('Quality','FontSize',15)
            title(strcat(T_F{f},{' '},T_D{j}),'FontSize',18)
            print(strcat('Outputs/Curves/',T_D{j},'_',T_T{t},'_',T_F{f}),'-depsc')
            close
        end
    end
end
