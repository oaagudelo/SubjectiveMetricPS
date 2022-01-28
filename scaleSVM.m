function [trn, val, tst, uData] = scaleSVM(trn, val, tst, lower, upper, uData)

%--------------------------------------------------------------------------
% Description:
%
%   [trn, val, tst, uData] = scaleSVM(trn, val, tst, lower, upper, uData)
%
%   uniformly scale the data to the range [lower, upper]
%
% INPUT:
%   trn
%       trn.X = the X matrix (n-by-d)
%       trn.y = the y labels [+1, -1] (n-by-1)  % won't be used for scaling
%   val
%       the same sturct as `trn'
%   tst
%       the same sturct as `trn'
%   lower
%       could be 0 or -1
%   upper
%       generally set to 1
%   uData
%       optinal input argument, only if Universum SVM were performed
%       the same sturct as `trn'
%
% OUTPUT:
%   trn
%   val
%   tst
%   uData
%       all scaled to [lower, upper]
%
% Author: Sauptik Dhar, Han-Tai Shiao
%--------------------------------------------------------------------------

    data = trn;
    [maxV, I] = max(data);
    [minV, I] = min(data);
    [R, C] = size(data);
    scaled = (data-ones(R, 1)*minV).*(ones(R, 1)*((upper-lower)*ones(1, C)./(maxV-minV))) +lower;

    for i = 1:size(data, 2)
        if (all(isnan(scaled(:, i))))
            scaled(:, i) = 0;
        end
    end
    trn = scaled;

    % ######## scale the validation data to the range of training data ##########
     if isempty(val)
         val = [];
     else
        data = val;
        [R, C] = size(data);
        scaled = (data-ones(R, 1)*minV).*(ones(R, 1)*((upper-lower)*ones(1, C)./(maxV-minV))) +lower;
        for i = 1:size(data, 2)
            if (all(isnan(scaled(:, i))))
                scaled(:, i) = 0;
            end
        end
        val = scaled;
    end

    % ###### scale the test data to the range of training data ###########
    data = tst;
    [R, C] = size(data);
    scaled = (data-ones(R, 1)*minV).*(ones(R, 1)*((upper-lower)*ones(1, C)./(maxV-minV))) +lower;

    for i = 1:size(data, 2)
        if (all(isnan(scaled(:, i))))
            scaled(:, i) = 0;
        end
    end
    tst = scaled;

    % ###### scale the universum data to the range of training data ###########
     if (exist('uData', 'var'))
         data = uData;
         [R, C] = size(data);
         scaled = (data-ones(R, 1)*minV).*(ones(R, 1)*((upper-lower)*ones(1, C)./(maxV-minV))) +lower;

         for i = 1:size(data, 2)
             if (all(isnan(scaled(:, i))))
                 scaled(:, i) = 0;
             end
         end
        uData = scaled;
    end
