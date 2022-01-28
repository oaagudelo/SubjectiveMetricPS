 function [I, T_F, T_M] = PS_Images(MS_U ,PAN, ratio, sensor)
%% %%%%%%%%%%%%%%%%%%%%%%%% PS Techniques %%%%%%%%%%%%%%%%%%%%%%%%%%
[M,N,L,K,J,Q,T]=size(MS_U);
I = zeros(M,N,L,K,J,Q,T,10);
PAN = double(PAN);
T_F = {'BDSD','PCA', 'MTF-GLP-CBD', 'ATWT-M2'};
T_M = {'CS', 'CS','MRA','MRA'};
for k = 1:K
    for j = 1:J
        for q =1:Q
            for t=1:T
                % Component Substitution
                cd BDSD
                I(:,:,:,k,j,q,t,1) = BDSD(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio,128,sensor{k});
                cd ..

                cd PCA
                I(:,:,:,k,j,q,t,2) = PCA(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t));
                cd ..
                
                cd IHS
                I(:,:,:,k,j,q,t,3) = IHS(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t));
                cd ..
                
                cd Brovey
                I(:,:,:,k,j,q,t,4) = Brovey(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t));
                cd ..
                
                cd GS
                I(:,:,:,k,j,q,t,5) = GS(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t));
                cd ..
                % Multi-resolution Analysis

                cd GS
                I(:,:,:,k,j,q,t,6) = GS2_GLP(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio,sensor{k},'');
                cd .. 
                
                cd Wavelet
                I(:,:,:,k,j,q,t,7) = ATWT_M2(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio);
                cd ..
                
                cd HPF
                I(:,:,:,k,j,q,t,8) = HPF(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio);
                cd ..
                
                cd SFIM
                I(:,:,:,k,j,q,t,9) = SFIM(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio);
                cd ..
                
                cd Wavelet
                I(:,:,:,k,j,q,t,10) = AWLP(MS_U(:,:,:,k,j,q,t),PAN(:,:,k,j,q,t),ratio);
                cd ..
            end
        end
    end
end
if J==Q==T==1
    I = reshape(I,M,N,L,K,10);
end

end