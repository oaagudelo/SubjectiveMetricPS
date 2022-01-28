close all;
[M,N,L,K,J,Q,F]=size(ALL_PS_D);
mark = {'*-','+-','o-','d-','s-'};
scales=[1,0.5,0.25];
f=1;
k=1;
t=1;
l=1;
for s=1:3
    for q=1:Q
        subplot(3,3,(s-1)*3+q)
        imrep = imresize(ALL_MS(:,:,l,k),scales(s));
        mscn = calculate_mscn(imrep);
        [D,X] = hist(mscn(:),500);
        plot(X, D/max(D),mark{2},'markers',3);
        hold on
        imrep = imresize(ALL_MS_U(:,:,l,k),scales(s));
        mscn = calculate_mscn(imrep);
        [D,X] = hist(mscn(:),500);
        plot(X, D/max(D),mark{2},'markers',3);
        hold on
        imrep = imresize(ALL_PS(:,:,l,k,f),scales(s)); 
        mscn = calculate_mscn(imrep);
        [D,X] = hist(mscn(:),500);
        plot(X, D/max(D),mark{1},'markers',3);
        hold on
        for j=1:J
            imrep = imresize(ALL_PS_D(:,:,l,k,j,q,t,f),scales(s));     
            mscn = calculate_mscn(imrep);
            [D,X] = hist(mscn(:),500);
            plot(X, D/max(D),mark{2+j},'markers',3);
            hold on
        end
        set(gca,'FontSize',6);
        axis([-0.1 0.1 0 1]);
        xlabel('Normalized Coefficients','FontSize',8)
        ylabel('Number of Coefficients','FontSize',8)
        legend([T_F(1:2),T_F(2+f),T_D(2:4)],'location','best', 'Interpreter', 'none','fontsize',6);
        title(T_L{q+1},'FontSize',10)
    end
end
