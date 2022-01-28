function feats_NIQE =computefeaturesNIQE(fused,blocksizerow,blocksizecol,...
    blockrowoverlap,blockcoloverlap,mu_prisparam,cov_prisparam)

%fused: multiespectral image MxNx4
%feats: NIQE features extracted from an image
featnum=18;
for k=1:size(fused,3)
   im=fused(:,:,k);
   im               = double(im);                
[row col]        = size(im);
block_rownum     = floor(row/blocksizerow);
block_colnum     = floor(col/blocksizecol);

im               = im(1:block_rownum*blocksizerow,1:block_colnum*blocksizecol);              
[row col]        = size(im);
block_rownum     = floor(row/blocksizerow);
block_colnum     = floor(col/blocksizecol);
im               = im(1:block_rownum*blocksizerow, ...
                   1:block_colnum*blocksizecol);               
window           = fspecial('gaussian',7,7/6);
window           = window/sum(sum(window));
scalenum         = 2;
warning('off')

feat             = [];


for itr_scale = 1:scalenum

    
mu                       = imfilter(im,window,'replicate');
mu_sq                    = mu.*mu;
sigma                    = sqrt(abs(imfilter(im.*im,window,'replicate') - mu_sq));
structdis                = (im-mu)./(sigma+1);
              
               
               
feat_scale               = blkproc(structdis,[blocksizerow/itr_scale blocksizecol/itr_scale], ...
                           [blockrowoverlap/itr_scale blockcoloverlap/itr_scale], ...
                           @computefeature);
feat_scale               = reshape(feat_scale,[featnum ....
                           size(feat_scale,1)*size(feat_scale,2)/featnum]);
feat_scale               = feat_scale';


if(itr_scale == 1)
sharpness                = blkproc(sigma,[blocksizerow blocksizecol], ...
                           [blockrowoverlap blockcoloverlap],@computemean);
sharpness                = sharpness(:);
end

feat                     = [feat feat_scale];

im =imresize(im,0.5);

end

feats_NIQE{k}=feat;

end