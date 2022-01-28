function pair = pair_products(im,itr_shift)

structdis = calculate_mscn_m(im);

shifts = [0 1; 1 0; 1 1; 1 -1];


% circular shift coefficients to calculate pair products
shifted_structdis = circshift(structdis,shifts(itr_shift,:));
% calculate pair products
pair = structdis(:).*shifted_structdis(:);


end