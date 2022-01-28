function [D,X] = computeGoodallHist(imi,group)
% Dependencies:
% - To compute steerable pyramid coefficients: matlabPyrTools.
%   Available: http://www.cns.nyu.edu/lcv/software.php
%
% Input:
% im    = input image coefficients
% group = string of group features to be computed
%
% Output:
% feat  = compute the 46 dimensional feature vector 

% default features to be computed
if nargin == 1
    group = 'f+pp+pd+sp';
end

% convert to grayscale double and normalize
imi = im2double(imi);
imi = (imi - min(imi(:)));
imi = imi/max(imi(:));

[~,~,L,K]=size(imi);

D = [];
X = [];

% MSCN coefficients
for k= 1:K
    for l= 1:L
        structdis(:,:,l,k) = calculate_mscn(imi(:,:,l,k));
    end
end
if strfind(group,'f')>0
    [d,x] = hist(structdis(:),1000);
    D = [D; d];
    X = [X; x];
end
% paired product coefficients
shifts = [0 1; 1 0; 1 1; 1 -1];

if strfind(group,'pp')>0
    for itr_shift = 1:4
        for k= 1:K
            for l= 1:L
                % circular shift coefficients to calculate pair products
                shifted_structdis = circshift(structdis(:,:,l,k),shifts(itr_shift,:));
                % calculate pair products
                pair(:,:,l,k) = structdis(:,:,l,k).*shifted_structdis;
                % calculate pair product features: 
                % pp1 shape, pp2 mean of distribution, pp3 leftstd, pp4 rightstd, 
            end
        end
        [d,x] = hist(pair(:),1000);
        D = [D; d];
        X = [X; x];
    end
end

% log derivative paired product coefficients
if strfind(group,'pd')>0
    % calculate log coefficients
    logderdis = log(abs(structdis) + 0.1);
    for itr_shift = 1:4
        for k= 1:K
            for l= 1:L
                % circular shift to log coefficients to calculate first 4 log
                % derivative coefficients
                shifted_logderdis = circshift(logderdis(:,:,l,k),shifts(itr_shift,:));
                % calculate log derivative coefficients
                pair(:,:,l,k) = shifted_logderdis - logderdis(:,:,l,k);
            end
        end
        [d,x] = hist(pair(:),1000);
        D = [D; d];
        X = [X; x];
    end

    shift1 = [-1 0; 0 0; -1 -1];
    shift2 = [1 0; 1 1; 1 1];
    shift3 = [0 -1; 0 1; -1 1];
    shift4 = [0 1; 1 0; 1 -1];
    sign = [1,1,1];
    for itr_shift = 1:3
        for k= 1:K
            for l= 1:L
            % circular shift to log coefficients to calculate last 3 log
            % derivative coefficients
            shifted_logderdis1 = circshift(logderdis(:,:,l,k),shift1(itr_shift,:));
            shifted_logderdis2 = circshift(logderdis(:,:,l,k),shift2(itr_shift,:));
            shifted_logderdis3 = circshift(logderdis(:,:,l,k),shift3(itr_shift,:));
            shifted_logderdis4 = circshift(logderdis(:,:,l,k),shift4(itr_shift,:));
            % calculate log derivative coefficients
            pair(:,:,l,k) = shifted_logderdis1 + sign(itr_shift).*shifted_logderdis2...
                -shifted_logderdis3 -shifted_logderdis4;
            end
        end
        [d,x] = hist(pair(:),1000);
        D = [D; d];
        X = [X; x];
    end
end

% steerable pyramid coefficients
if strfind(group,'sp')>0
    %parameters of steerable pyramid features
    num_or = 6;
    num_scales = 1;
    band = cell(num_or*num_scales,1);
    %calculate seerable pyramid subbands
    for k= 1:K
            for l= 1:L
                [pyr, pind] = buildSFpyr(imi(:,:,l,k),num_scales,num_or-1);
                [subband, ~] = norm_sender_normalized(pyr,pind,num_scales,num_or,1,1,3,3,50);
                for itr_shift = 1:num_or*num_scales
                    band{itr_shift} = [band{itr_shift} subband{itr_shift}'];
                end
            end
    end
    for itr_shift = 1:num_or*num_scales
        %sp1 shape, sp2 standard deviation
        [d,x] = hist(band{itr_shift},1000);
        D = [D; d];
        X = [X; x];
    end
end
end

