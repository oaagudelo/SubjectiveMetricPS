function  hist_f3( ALL_PS_D ,ALL_PS, ALL_MS)
[M,N,L,K,J,Q,F]=size(ALL_PS_D);
mark = {'*-','+-','o-','d-'};
T_D = {' Blur', ' AWGN',' UD', ' REF'};
T_T = {'BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
T_L = {'Level-1','Level-2','Level-3'};
for k=1:1
    for f=1:F
        figure;
        for j=1:J
            for q=1:Q
                imrep = ALL_PS_D(:,:,:,k,j,q,f);
                mscnmap = calculate_mscn_m(imrep);
                [D,X] = hist(reshape(mscnmap,M*N*L,1),256);
                subplot(1,3,j)
                plot(X, D/max(D),mark{q},'markers',3);
                set(gca,'FontSize',6);
                axis([-0.04 0.04 0 1]);
                xlabel('Normalized Coefficients','FontSize',8)
                ylabel('Number of Coefficients','FontSize',8)
                legend(T_L,'location','best', 'Interpreter', 'none','fontsize',6);
                title(strcat('MSCN',T_D{j}),'FontSize',10)
                hold on
                
            end 
            imrep = ALL_PS_D(:,:,:,k,j,3,f);
            mscnmap = calculate_mscn_m(imrep);
            [D,X] = hist(reshape(mscnmap,M*N*L,1),256);
            subplot(1,3,3)
            plot(X, D/max(D),mark{j},'markers',3);
            set(gca,'FontSize',6);
            axis([-0.04 0.04 0 1]);
            xlabel('Normalized Coefficients','FontSize',8)
            ylabel('Number of Coefficients','FontSize',8)
            legend(T_D,'location','best', 'Interpreter', 'none','fontsize',6);
            title(strcat('MSCN'),'FontSize',10)
            hold on
        end
        imrep = ALL_PS(:,:,:,k,f);
        mscnmap = calculate_mscn_m(imrep);
        [D,X] = hist(reshape(mscnmap,M*N*L,1),256);
        subplot(1,3,3)
        plot(X, D/max(D),mark{3},'markers',3);
        set(gca,'FontSize',6);
        axis([-0.04 0.04 0 1]);
        xlabel('Normalized Coefficients','FontSize',8)
        ylabel('Number of Coefficients','FontSize',8)
        legend(T_D,'location','best', 'Interpreter', 'none','fontsize',6);
        title(strcat('MSCN'),'FontSize',10)
        hold on
        
        imrep = ALL_MS(:,:,:,k);
        mscnmap = calculate_mscn_m(imrep);
        [D,X] = hist(reshape(mscnmap,M*N*L,1),256);
        subplot(1,3,3)
        plot(X, D/max(D),mark{4},'markers',3);
        set(gca,'FontSize',6);
        axis([-0.04 0.04 0 1]);
        xlabel('Normalized Coefficients','FontSize',8)
        ylabel('Number of Coefficients','FontSize',8)
        legend(T_D,'location','best', 'Interpreter', 'none','fontsize',6);
        title(strcat('MSCN'),'FontSize',10)
        hold on
        
        suptitle(strcat(T_T{f}))
        print(sprintf(['Outputs/Histogram3_' T_T{f} '.pdf']),'-dpdf','-bestfit');
        close
    end
end

end
