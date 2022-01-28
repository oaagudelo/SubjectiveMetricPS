clc;
clear all;
close all;
%% Plot Qd curves
load('Outputs/Metrics/IQA.mat');
%%
dis = {'Blur','AWGN','RAD'};
x = [3 4 5 6 7; 0.05 0.075 0.1 0.125 0.15;6 5 4 3 2];
fus = {'BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
for i=1:3
    for f=1:6
        subplot(3,6,(i-1)*6+f)
        p = reshape(IQA_FUS_DIS(:,f,i,:,1,8),5,5);
        plot(x(i,:),p')
        set(gca,'fontsize',8)
%         hold on
%         p = reshape(Qd_FUSED_DISTORTED(:,f,i,:,2),5,5);
%         plot(x(i,:),p')
%         hold on
%         p = reshape(Qd_FUSED_DISTORTED(:,f,i,:,3),5,5);
%         plot(x(i,:),p')
        ylabel(strcat('Quality of',{' '},dis{i}))
        title(fus{f})
        switch i
            case 1
                xlabel('Standard deviation of Gaussian filter','FontSize',8)
                axis([x(i,1) x(i,5) -inf inf])
            case 2
                xlabel('Standard deviation of Gaussian white noise','FontSize',8)
                axis([x(i,1) x(i,5) -inf inf])
            case 3
                xlabel('Representation bits','FontSize',8)
                axis([x(i,5) x(i,1) -inf inf])
        end
    end
end