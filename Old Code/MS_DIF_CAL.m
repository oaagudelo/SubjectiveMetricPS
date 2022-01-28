function [I_DIF] = MS_DIF_CAL(I)
[m,n,l,k]=size(I);
I_DIF = zeros(m,n,((l^2)-l)/2,k);
for z = 1:k 
    c = 1;
    for x=1:l
        for y=(x+1):l
            I_DIF(:,:,c,z) = normalize(I(:,:,x,z) - I(:,:,y,z));
            c = c+1;
        end
    end
end
end