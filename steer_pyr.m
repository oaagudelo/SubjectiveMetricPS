function steerpyr = steer_pyr( MS )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
   
num_or = 6;
num_scales = 1;
[~,~,L]=size(MS);
for l=1:L
        [pyr, pind] = buildSFpyr(MS(:,:,l),num_scales,num_or-1);
        [subband, ~] = norm_sender_normalized(pyr,pind,num_scales,num_or,1,1,3,3,50);
        for p =1:num_or*num_scales
            steerpyr(:,l,p) = subband{p};
        end       
end

end

