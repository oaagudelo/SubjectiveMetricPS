function  hist_f7( ALL_PS_D ,ALL_PS, ALL_MS)
[~,~,~,~,~,Q,F]=size(ALL_PS_D);
mark = {'*-','+-','o-','d-'};
T_D = {' Blur', ' AWGN',' UD', ' REF'};
T_T = {'BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
T_S = {'Coliseum','River','Villa','Road','Urban','Test'};
T_L = {'Level-1','Level-2','Level-3'};
T_P = {'$d_1^{0^\circ}$','$d_1^{30^\circ}$','$d_1^{60^\circ}$','$d_1^{90^\circ}$','$d_1^{120^\circ}$','$d_1^{150^\circ}$'};
T_PF = {'d0','d30','d60','d90','d120','d150'};
steerpyr  = steerable_pyr( ALL_PS_D,ALL_PS,ALL_MS);

for k=1:1
    for p=1:6
        figure;
        for f=1:F
            ax = subplot(F, 4, (f-1)*4+1);
            text(0.5,0.5,strcat(T_P{p},{' '},T_T{f}),'FontSize',6,'interpreter','latex');
            set ( ax, 'visible', 'off')
                for q=1:Q
                    pair = steerpyr.psd(:,:,k,f,1,q,p);
                    [D,X] = hist(pair(:),128);
                    subplot(F,4,(f-1)*4+q+1)
                    plot(X, D/max(D),mark{1},'markers',2);
                    hold on     
                    pair = steerpyr.psd(:,:,k,f,2,q,p);
                    [D,X] = hist(pair(:),128);
                    plot(X, D/max(D),mark{2},'markers',2);
                    hold on
                    pair = steerpyr.ps(:,:,k,f,p);
                    [D,X] = hist(pair(:),128);
                    plot(X, D/max(D),mark{3},'markers',2);
                    hold on
                    pair = steerpyr.ms(:,:,k,p);
                    [D,X] = hist(pair(:),128);
                    plot(X, D/max(D),mark{4},'markers',2);
                    hold on
                    set(gca,'FontSize',6);
                    axis([-0.02 0.02 0 1]);
                    xlabel('Normalized Coefficients','FontSize',4)
                    ylabel('Number of Coefficients','FontSize',4)
                    legend(T_D,'FontSize',3,'location','best');
                    title(T_L{q},'FontSize',4)
                end    
        end
    print(sprintf(['Outputs/Histogram7_' T_S{k} '_' T_PF{p} '.pdf']),'-dpdf','-fillpage');
    close
    end
end
end
