function  steerpyr  = steerable_pyr( ALL_PS_D,ALL_PS,ALL_MS)
num_or = 6;
num_scales = 1;
[~,~,L,K,J,Q,F]=size(ALL_PS_D);
for l=1:L
    for k=1:1
        [pyr, pind] = buildSFpyr(ALL_MS(:,:,l,k),num_scales,num_or-1);
        [subband, ~] = norm_sender_normalized(pyr,pind,num_scales,num_or,1,1,3,3,50);
        for p =1:6
            steerpyr.ms(:,l,k,p) = subband{p};
        end
        for f=1:F
            [pyr, pind] = buildSFpyr(ALL_PS(:,:,l,k,f),num_scales,num_or-1);
            [subband, ~] = norm_sender_normalized(pyr,pind,num_scales,num_or,1,1,3,3,50);
            for p =1:6
                steerpyr.ps(:,l,k,f,p) = subband{p};
            end
            for j=1:J
                for q=1:Q
                    [pyr, pind] = buildSFpyr(ALL_PS_D(:,:,l,k,j,q,f),num_scales,num_or-1);
                    [subband, ~] = norm_sender_normalized(pyr,pind,num_scales,num_or,1,1,3,3,50);
                    for p =1:6
                        steerpyr.psd(:,l,k,f,j,q,p) = subband{p};
                    end
                end
            end
        end
    end
end
end

