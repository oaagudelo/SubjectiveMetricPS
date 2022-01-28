 function I = PS_ImagesMSR(MS_U ,PAN, ratio, sensor)
%% %%%%%%%%%%%%%%%%%%%%%%%% PS Techniques %%%%%%%%%%%%%%%%%%%%%%%%%%
[M,N,~]=size(PAN);
[~,~,S,K,L,J,Q]=size(MS_U);
I = zeros(M,N,L,K,L,J,Q,6);
PAN = double(PAN);
for k = 1:K
    for l=1:L
        for j = 1:J
            for q =1:Q
                    % Component Substitution
                    cd BDSD
                    I(:,:,:,k,l,j,q,1) = BDSD(MS_U(:,:,:,k,l,j,q),PAN(:,:,k),ratio,128,sensor{1});
                    cd ..

                    cd PCA
                    I(:,:,:,k,l,j,q,2) = PCA(MS_U(:,:,:,k,l,j,q),PAN(:,:,k));
                    cd ..

                    cd IHS
                    I(:,:,:,k,l,j,q,3) = IHS(MS_U(:,:,:,k,l,j,q),PAN(:,:,k));
                    cd ..

                    % Multi-resolution Analysis

                    cd GS
                    I(:,:,:,k,l,j,q,4) = GS2_GLP(MS_U(:,:,:,k,l,j,q),PAN(:,:,k),ratio,sensor{1},'');
                    cd .. 

                    cd Wavelet
                    I(:,:,:,k,l,j,q,5) = ATWT_M2(MS_U(:,:,:,k,l,j,q),PAN(:,:,k),ratio);
                    cd ..

                    cd HPF
                    I(:,:,:,k,l,j,q,6) = HPF(MS_U(:,:,:,k,l,j,q),PAN(:,:,k),ratio);
                    cd ..

            end
        end
    end
end
if (L==1 && J==1 && Q==1)
    t = I;
    I = reshape(t,M,N,S,K,6);
end

end