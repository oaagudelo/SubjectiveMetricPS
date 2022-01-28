 function I = PS_ImagesR(MS_U ,PAN, ratio, sensor)
%% %%%%%%%%%%%%%%%%%%%%%%%% PS Techniques %%%%%%%%%%%%%%%%%%%%%%%%%%
[M,N,K,J,Q]=size(PAN);
[~,~,L,~]=size(MS_U);
I = zeros(M,N,L,K,J,Q,6);
PAN = double(PAN);
for k = 1:K
    for j = 1:J
        for q =1:Q
                % Component Substitution
                cd BDSD
                I(:,:,:,k,j,q,1) = BDSD(MS_U(:,:,:,k),PAN(:,:,k,j,q),ratio,128,sensor{1});
                cd ..

                cd PCA
                I(:,:,:,k,j,q,2) = PCA(MS_U(:,:,:,k),PAN(:,:,k,j,q));
                cd ..
                
                cd IHS
                I(:,:,:,k,j,q,3) = IHS(MS_U(:,:,:,k),PAN(:,:,k,j,q));
                cd ..
                
                % Multi-resolution Analysis

                cd GS
                I(:,:,:,k,j,q,4) = GS2_GLP(MS_U(:,:,:,k),PAN(:,:,k,j,q),ratio,sensor{1},'');
                cd .. 
                
                cd Wavelet
                I(:,:,:,k,j,q,5) = ATWT_M2(MS_U(:,:,:,k),PAN(:,:,k,j,q),ratio);
                cd ..
                
                cd HPF
                I(:,:,:,k,j,q,6) = HPF(MS_U(:,:,:,k),PAN(:,:,k,j,q),ratio);
                cd ..
                
        end
    end
end
if (J==1 && Q==1)
    t = I;
    I = reshape(t,M,N,L,K,6);
end

end