function [MS_DT ,PAN_DT] = Distorted_Images(MS_D ,PAN_D, MS, PAN)
[~,~,~,J,Q]=size(MS_D);
for j = 1:J
    for q =1:Q
        MS_DT(:,:,:,j,q,1) = MS(:,:,:); 
        PAN_DT(:,:,j,q,1) = PAN_D(:,:,j,q);

        MS_DT(:,:,:,j,q,2) = MS_D(:,:,:,j,q); 
        PAN_DT(:,:,j,q,2) = PAN(:,:);

        MS_DT(:,:,:,j,q,3) = MS_D(:,:,:,j,q); 
        PAN_DT(:,:,j,q,3) = PAN_D(:,:,j,q);

    end
end
end