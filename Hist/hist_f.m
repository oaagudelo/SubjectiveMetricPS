function  hist_f( ALL_PS_D )
[M,N,L,K,J,Q,F]=size(ALL_PS_D);
mark = {'*-','+-','o-'};
T_D = {' Blur', ' AWGN'};
T_T = {'BDSD','PCA','IHS','MTF-GLP-CBD','ATWT-M2','HPF'};
T_L = {'Level-1','Level-2','Level-3'};
I_R = {'Gray','Chroma'};z
for k=1:1
    for f=1:F
        figure;
        for j=1:J
            for q=1:Q
                if im ==1
                    imrep = rgb2gray(ALL_PS_D(:,:,3:-1:1,k,j,q,f));
                else
                    lab = convertRGBToLAB(ALL_PS_D(:,:,3:-1:1,k,j,q,f));
                    A = double(lab(:,:,2));
                    B = double(lab(:,:,3));
                    % Compute the chroma map.
                    imrep = sqrt(A.*A + B.*B);
                end
                [~, DoGSigma,DoGSigma1] = DoGFeat(imrep);
                divNormDoGSigma = divisiveNormalization(DoGSigma);
                [D,X] = hist(reshape(divNormDoGSigma,M*N,1),256);
                subplot(2,3,(j-1)*3+1)
                plot(X, D/max(D),mark{q},'markers',3);
                set(gca,'FontSize',6);
                if im ==1
                    axis([-0.002 0.002 0 1]);
                else
                    axis([-0.04 0.04 0 1]);
                end
                xlabel('Normalized Coefficients','FontSize',8)
                ylabel('Number of Coefficients','FontSize',8)
                legend(T_L,'location','best', 'Interpreter', 'none','fontsize',6);
                title(strcat('DoG_{\sigma}',T_D{j}),'FontSize',10)
                hold on
                divNormDoGSigma1 = divisiveNormalization(DoGSigma1);
                [D,X] = hist(reshape(divNormDoGSigma1,M*N,1),256);
                subplot(2,3,(j-1)*3+2)
                plot(X, D/max(D),mark{q},'markers',3);
                set(gca,'FontSize',6);
                if im == 1
                    axis([-0.0003 0.0003 0 1]);
                else
                    axis([-0.005 0.005 0 1]);
                end
                xlabel('Normalized Coefficients','FontSize',8)
                ylabel('Number of Coefficients','FontSize',8)
                legend(T_L,'location','best', 'Interpreter', 'none','fontsize',6);
                title(strcat('DoG''_{\sigma}',T_D{j}),'FontSize',10)
                hold on
                mscn = calculate_mscn(imrep);
                [D,X] = hist(reshape(mscn,M*N,1),256);
                subplot(2,3,(j-1)*3+3)
                plot(X, D/max(D),mark{q},'markers',3);
                set(gca,'FontSize',6);
                if im ==1
                    if j ==1
                        axis([-0.02 0.02 0 1]);
                    else
                         axis([-0.08 0.08 0 1]);
                    end
                else
                    if j ==1
                        axis([-0.3 0.3 0 1]);
                    else
                         axis([-0.5 0.5 0 1]);
                    end
                end
                xlabel('Normalized Coefficients','FontSize',8)
                ylabel('Number of Coefficients','FontSize',8)
                legend(T_L,'location','best', 'Interpreter', 'none','fontsize',6);
                title(strcat('MSCN',T_D{j}),'FontSize',10)
                hold on
            end
        end
        suptitle(strcat(I_R{im},{' '},T_T{f}))
        print(sprintf(['Outputs/Histogram_' I_R{im} '_' T_T{f} '.pdf']),'-dpdf','-bestfit');
        close
    end
end

end
