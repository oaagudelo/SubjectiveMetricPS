function  hist_f9( ALL_PS_D ,ALL_PS, ALL_MS)
[M,N,L,K,S,J,Q,F]=size(ALL_PS_D);
mark = {'*-','+-','o-','d-'};
T_D = {' Blur', ' AWGN',' UD', ' REF'};
T_T = {'BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
T_S = {'Coliseum','River','Villa','Road','Urban','Test'};
T_L = {'Level-1','Level-2','Level-3'};
T_P = {'H','V','D1','D2'};
T_DT = {'Blue-D','Green-D','Red-D','NIR-D'};
for k=1:1
for s =1:S
    for p=1:4
        figure;
        for f=1:F
            ax = subplot(F, 4, (f-1)*4+1);
            text(0.5,0.5,strcat(T_P{p},{' '},T_T{f}),'FontSize',6,'interpreter','latex');
            set ( ax, 'visible', 'off')
                for q=1:Q
                    imrep = ALL_PS_D(:,:,:,k,s,1,q,f);
                    pair = pair_products(imrep,p);
                    [D,X] = hist(pair,1024);
                    subplot(F,4,(f-1)*4+q+1)
                    plot(X, D/max(D),mark{1},'markers',2);
                    hold on     
                    imrep = ALL_PS_D(:,:,:,k,s,2,q,f);
                    pair = pair_products(imrep,p);
                    [D,X] = hist(pair,1024);
                    plot(X, D/max(D),mark{2},'markers',2);
                    hold on
                    imrep = ALL_PS(:,:,:,k,f);
                    pair = pair_products(imrep,p);
                    [D,X] = hist(pair,1024);
                    plot(X, D/max(D),mark{3},'markers',2);
                    hold on
                    imrep = ALL_MS(:,:,:,k);
                    pair = pair_products(imrep,p);
                    [D,X] = hist(pair,1024);
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
    print(sprintf(['Outputs/Chroma/Histogram9_' T_S{k} '_' T_DT{s} '_' T_P{p} '.pdf']),'-dpdf','-fillpage');
    close
    end
end
end
end