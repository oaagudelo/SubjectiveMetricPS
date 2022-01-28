close all;
clear all;
clc;
%%
load('Outputs/Histograms.mat');
T_D = {'org','Blr', 'AWGN','RAD'};
T_L = {'Level-1','Level-2','Level-3'};
T_T = {'P-D', 'MS-D', 'PMS-D'};
T_F = {'BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
T_feat = {'MSCN','H','V','D1','D2','PD1','PD2','PD3','PD4','PD5','PD6','PD7','d0','d30','d60','d90','d120','d150'};
mark = {'*-','+-','o-','d-'};
[H,~,L,J,Q,T,F] = size(D);
ylimit = 0.05;
N = 50;
%% Luminance Histograms
for h=1:H
    for q =1:Q
        for t=1:T
            for f =1:F
                figure
                rankx = [];
                ranky = [];
                d = D0(h,:,1,f);
                x = X0(h,:,1,f);               
                d = d/max(d);
                x = x(d>ylimit);
                d = d(d>ylimit);
                n = length(x);
                if n>N 
                    x =  downsample(x,ceil(n/N));
                    d =  downsample(d,ceil(n/N));
                end
                rankx = [rankx x];
                ranky = [ranky d];
                plot(x,d,mark{1})
                hold on
                for j=1:J
                    d = D(h,:,1,j,q,t,f);
                    x = X(h,:,1,j,q,t,f);
                    d = d/max(d);
                    x = x(d>ylimit);
                    d = d(d>ylimit);
                    n = length(x);
                    if n>N 
                        x =  downsample(x,ceil(n/N));
                        d =  downsample(d,ceil(n/N));
                    end
                    plot(x,d,mark{1+j},'MarkerSize',10)
                    hold on
                end
                set(gca,'FontSize',12);
                lim = min([abs(min(rankx)) max(rankx)]);
                axis([-lim lim min(ranky) 1])
                axis square
                xlabel('Normalized Coefficients','FontSize',15)
                ylabel('Number of Coefficients','FontSize',15)
                legend(T_D, 'Interpreter', 'none','FontSize',12);
                title(T_L{q},'FontSize',18)
                print(strcat('Outputs/Histograms/Luminance_',T_feat{h},'_',T_L{q},'_',T_T{t},'_',T_F{f}),'-depsc')
                close
            end
        end
    end
end
%% Color Histograms
for h=1:H
    for q =1:Q
        for t=1:T
            for f =1:F
                figure
                rankx = [];
                ranky = [];
                d = D0(h,:,2,f);
                x = X0(h,:,2,f);
                d = d/max(d);
                x = x(d>ylimit);
                d = d(d>ylimit);
                n = length(x);
                if n>N 
                    x =  downsample(x,ceil(n/N));
                    d =  downsample(d,ceil(n/N));
                end
                rankx = [rankx x];
                ranky = [ranky d];
                plot(x,d,mark{1})
                hold on
                for j=1:J
                    d = D(h,:,2,j,q,t,f);
                    x = X(h,:,2,j,q,t,f);
                    d = d/max(d);
                    x = x(d>ylimit);
                    d = d(d>ylimit);
                    n = length(x);
                    if n>N 
                        x =  downsample(x,ceil(n/N));
                        d =  downsample(d,ceil(n/N));
                    end
                    plot(x,d,mark{1+j},'MarkerSize',10)
                    hold on
                end
                set(gca,'FontSize',12);
                lim = min([abs(min(rankx)) max(rankx)]);
                axis([-lim lim min(ranky) 1])
                axis square
                xlabel('Normalized Coefficients','FontSize',15)
                ylabel('Number of Coefficients','FontSize',15)
                legend(T_D, 'Interpreter', 'none','FontSize',12);
                title(T_L{q},'FontSize',18)
                print(strcat('Outputs/Histograms/Color_',T_feat{h},'_',T_L{q},'_',T_T{t},'_',T_F{f}),'-depsc')
                close
            end
        end
    end
end
