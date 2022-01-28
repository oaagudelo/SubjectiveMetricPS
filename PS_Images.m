 function [I] = PS_Images(MS_U ,PAN, ratio, sensor)
%% %%%%%%%%%%%%%%%%%%%%%%%% PS Techniques %%%%%%%%%%%%%%%%%%%%%%%%%%
[M,N,L,K,J,Q,T]=size(MS_U);
for k = 1:K
    for j = 1:J
        for q =1:Q
            for t=1:T
                % Component Substitution
                cd BDSD
                I(:,:,:,k,j,q,t,1) = BDSD(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio,128,sensor{1});
                cd ..

                cd PCA
                I(:,:,:,k,j,q,t,2) = PCA(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t));
                cd ..
                
                cd IHS
                I(:,:,:,k,j,q,t,3) = IHS(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t));
                cd ..
                
                % Multi-resolution Analysis

                cd GS
                I(:,:,:,k,j,q,t,4) = GS2_GLP(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio,sensor{1},'');
                cd .. 
                
                cd Wavelet
                I(:,:,:,k,j,q,t,5) = ATWT_M2(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio);
                cd ..
                
                cd HPF
                I(:,:,:,k,j,q,t,6) = HPF(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio);
                cd ..
                
            end
        end
    end
end
if J==Q==T==1
    I = reshape(I,M,N,L,K,6);
end

end