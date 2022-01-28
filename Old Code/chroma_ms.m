function chroma = chroma_ms( MS )
[M,N,~,K,L,J,Q,F]=size(MS);
chroma = zeros(M,N,2,K,L,J,Q,F);
for k = 1:K
    for l=1:L
        for j = 1:J
            for q =1:Q
                for f=1:F
                    lab=convertRGBToLAB(MS(:,:,3:-1:1,k,l,j,q,f));
                    % Get the A and B components of the LAB color space.
                    A = double(lab(:,:,2));
                    B = double(lab(:,:,3));
                    % Compute the chroma map.
                    chroma(:,:,1,k,l,j,q,f) = sqrt(A.*A + B.*B);
                    lab=convertRGBToLAB(MS(:,:,4:-1:2,k,l,j,q,f));
                    % Get the A and B components of the LAB color space.
                    A = double(lab(:,:,2));
                    B = double(lab(:,:,3));
                    % Compute the chroma map.
                    chroma(:,:,2,k,l,j,q,f) = sqrt(A.*A + B.*B);
                end
            end
        end
    end
end
t = chroma;
if (L==1 && J==1 && Q==1)
    chroma = reshape(t,M,N,2,K,F);
    if f==1
        chroma = reshape(t,M,N,2,K);
    end
end
end

