function indexes  = PSIndex( I_MS, I_PCA, I_PCA_BLR , I_PCA_AWGN, I_PCA_RAD, I_HPF, I_HPF_BLR , I_HPF_AWGN, I_HPF_RAD ,ratio)
indexes = zeros(3,9,8,3);

% Quality Index Blocks
Qblocks_size = 32;
% Cut Final Image
flag_cut_bounds = 0;
dim_cut = 11;
% Threshold values out of dynamic range
thvalues = 0;
% Radiometric Resolution
L = 11;

for i=1:9   
    for j=1:3
        [indexes(j,i,1,1),indexes(j,i,1,2), indexes(j,i,1,3)] = indexes_evaluation(I_PCA,I_MS,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
        [indexes(j,i,2,1),indexes(j,i,2,2), indexes(j,i,2,3)] = indexes_evaluation(I_PCA_BLR(:,:,:,j,i),I_MS,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
        [indexes(j,i,3,1),indexes(j,i,3,2), indexes(j,i,3,3)] = indexes_evaluation(I_PCA_AWGN(:,:,:,j,i),I_MS,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
        [indexes(j,i,4,1),indexes(j,i,4,2), indexes(j,i,4,3)] = indexes_evaluation(I_PCA_RAD(:,:,:,j,i),I_MS,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
        
        [indexes(j,i,5,1),indexes(j,i,5,2), indexes(j,i,5,3)] = indexes_evaluation(I_HPF,I_MS,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
        [indexes(j,i,6,1),indexes(j,i,6,2), indexes(j,i,6,3)] = indexes_evaluation(I_HPF_BLR(:,:,:,j,i),I_MS,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
        [indexes(j,i,7,1),indexes(j,i,7,2), indexes(j,i,7,3)] = indexes_evaluation(I_HPF_AWGN(:,:,:,j,i),I_MS,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
        [indexes(j,i,8,1),indexes(j,i,8,2), indexes(j,i,8,3)] = indexes_evaluation(I_HPF_RAD(:,:,:,j,i),I_MS,ratio,L,Qblocks_size,flag_cut_bounds,dim_cut,thvalues);
    
    end
end

