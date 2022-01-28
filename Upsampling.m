function [ ALL_MS_U ] = Upsampling( ALL_MS, ratio)
[~,~,L,K,J,Q,T] = size(ALL_MS);
for l=1:L
    for k=1:K
        for j=1:J
            for q=1:Q
                for t=1:T
                    ALL_MS_U(:,:,l,k,j,q,t) = imresize(ALL_MS(:,:,l,k,j,q,t),ratio);
                end
            end
        end
    end
end
end

