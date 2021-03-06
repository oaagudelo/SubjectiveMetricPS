function  hist_f2( ALL_PS_D ,ALL_PS, ALL_MS)
[M,N,L,K,J,Q,F]=size(ALL_PS_D);
mark = {'*-','+-','o-','d-'};
T_D = {' Blur', ' AWGN',' UD', ' REF'};
T_T = {'BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
T_L = {'Level-1','Level-2','Level-3'};
I_R = {' Gray',' Chroma'};
for k=1:1
    for f=1:F
        figure;
        for j=1:J
            for q=1:Q
                imrep = rgb2gray(ALL_PS_D(:,:,3:-1:1,k,j,q,f));
                sigmaMap = computeSigmaMap(imrep);
                divNormDoGSigma = divisiveNormalization(sigmaMap);
                [D,X] = hist(reshape(divNormDoGSigma,M*N,1),256);
                subplot(2,3,j)
                plot(X, D/max(D),mark{q},'markers',3);
                set(gca,'FontSize',6);
                axis([-0.01 0.01 0 1]);
                xlabel('Normalized Coefficients','FontSize',8)
                ylabel('Number of Coefficients','FontSize',8)
                legend(T_L,'location','best', 'Interpreter', 'none','fontsize',6);
                title(strcat('MSCN_{\sigma}',I_R{1},T_D{j}),'FontSize',10)
                hold on
                
                lab = convertRGBToLAB(ALL_PS_D(:,:,3:-1:1,k,j,q,f));
                A = double(lab(:,:,2));
                B = double(lab(:,:,3));
                % Compute the chroma map.
                imrep = sqrt(A.*A + B.*B);
                sigmaMap = computeSigmaMap(imrep);
                divNormDoGSigma = divisiveNormalization(sigmaMap);
                [D,X] = hist(reshape(divNormDoGSigma,M*N,1),256);
                subplot(2,3,3+j)
                plot(X, D/max(D),mark{q},'markers',3);
                set(gca,'FontSize',6);
                axis([-0.2 0.2 0 1]);
                xlabel('Normalized Coefficients','FontSize',8)
                ylabel('Number of Coefficients','FontSize',8)
                legend(T_L,'location','best', 'Interpreter', 'none','fontsize',6);
                title(strcat('MSCN_{\sigma}',I_R{2},T_D{j}),'FontSize',10)
                hold on
            end 
            imrep = rgb2gray(ALL_PS_D(:,:,3:-1:1,k,j,3,f));
            sigmaMap = computeSigmaMap(imrep);
            divNormDoGSigma = divisiveNormalization(sigmaMap);
            [D,X] = hist(reshape(divNormDoGSigma,M*N,1),256);
            subplot(2,3,3)
            plot(X, D/max(D),mark{j},'markers',3);
            set(gca,'FontSize',6);
            axis([-0.01 0.01 0 1]);
            xlabel('Normalized Coefficients','FontSize',8)
            ylabel('Number of Coefficients','FontSize',8)
            legend(T_D,'location','best', 'Interpreter', 'none','fontsize',6);
            title(strcat('MSCN_{\sigma}',I_R{1}),'FontSize',10)
            hold on

            lab = convertRGBToLAB(ALL_PS_D(:,:,3:-1:1,k,j,3,f));
            A = double(lab(:,:,2));
            B = double(lab(:,:,3));
            % Compute the chroma map.
            imrep = sqrt(A.*A + B.*B);
            sigmaMap = computeSigmaMap(imrep);
            divNormDoGSigma = divisiveNormalization(sigmaMap);
            [D,X] = hist(reshape(divNormDoGSigma,M*N,1),256);
            subplot(2,3,6)
            plot(X, D/max(D),mark{j},'markers',3);
            set(gca,'FontSize',6);
            axis([-0.2 0.2 0 1]);
            xlabel('Normalized Coefficients','FontSize',8)
            ylabel('Number of Coefficients','FontSize',8)
            legend(T_D,'location','best', 'Interpreter', 'none','fontsize',6);
            title(strcat('MSCN_{\sigma}',I_R{2}),'FontSize',10)
            hold on
        end
        imrep = rgb2gray(ALL_PS(:,:,3:-1:1,k,f));
        sigmaMap = computeSigmaMap(imrep);
        divNormDoGSigma = divisiveNormalization(sigmaMap);
        [D,X] = hist(reshape(divNormDoGSigma,M*N,1),256);
        subplot(2,3,3)
        plot(X, D/max(D),mark{3},'markers',3);
        set(gca,'FontSize',6);
        axis([-0.01 0.01 0 1]);
        xlabel('Normalized Coefficients','FontSize',8)
        ylabel('Number of Coefficients','FontSize',8)
        legend(T_D,'location','best', 'Interpreter', 'none','fontsize',6);
        title(strcat('MSCN_{\sigma}',I_R{1}),'FontSize',10)
        hold on

        lab = convertRGBToLAB(ALL_PS(:,:,3:-1:1,k,f));
        A = double(lab(:,:,2));
        B = double(lab(:,:,3));
        % Compute the chroma map.
        imrep = sqrt(A.*A + B.*B);
        sigmaMap = computeSigmaMap(imrep);
        divNormDoGSigma = divisiveNormalization(sigmaMap);
        [D,X] = hist(reshape(divNormDoGSigma,M*N,1),256);
        subplot(2,3,6)
        plot(X, D/max(D),mark{3},'markers',3);
        set(gca,'FontSize',6);
        axis([-0.2 0.2 0 1]);
        xlabel('Normalized Coefficients','FontSize',8)
        ylabel('Number of Coefficients','FontSize',8)
        legend(T_D,'location','best', 'Interpreter', 'none','fontsize',6);
        title(strcat('MSCN_{\sigma}',I_R{2}),'FontSize',10)
        hold on
        
        imrep = rgb2gray(ALL_MS(:,:,3:-1:1,k));
        sigmaMap = computeSigmaMap(imrep);
        divNormDoGSigma = divisiveNormalization(sigmaMap);
        [D,X] = hist(reshape(divNormDoGSigma,M*N,1),256);
        subplot(2,3,3)
        plot(X, D/max(D),mark{4},'markers',3);
        set(gca,'FontSize',6);
        axis([-0.01 0.01 0 1]);
        xlabel('Normalized Coefficients','FontSize',8)
        ylabel('Number of Coefficients','FontSize',8)
        legend(T_D,'location','best', 'Interpreter', 'none','fontsize',6);
        title(strcat('MSCN_{\sigma}',I_R{1}),'FontSize',10)
        hold on

        lab = convertRGBToLAB(ALL_MS(:,:,3:-1:1,k));
        A = double(lab(:,:,2));
        B = double(lab(:,:,3));
        % Compute the chroma map.
        imrep = sqrt(A.*A + B.*B);
        sigmaMap = computeSigmaMap(imrep);
        divNormDoGSigma = divisiveNormalization(sigmaMap);
        [D,X] = hist(reshape(divNormDoGSigma,M*N,1),256);
        subplot(2,3,6)
        plot(X, D/max(D),mark{4},'markers',3);
        set(gca,'FontSize',6);
        axis([-0.2 0.2 0 1]);
        xlabel('Normalized Coefficients','FontSize',8)
        ylabel('Number of Coefficients','FontSize',8)
        legend(T_D,'location','best', 'Interpreter', 'none','fontsize',6);
        title(strcat('MSCN_{\sigma}',I_R{2}),'FontSize',10)
        hold on
        
        suptitle(strcat(T_T{f}))
        print(sprintf(['Outputs/Histogram2_' T_T{f} '.pdf']),'-dpdf','-bestfit');
        close
    end
end

end

