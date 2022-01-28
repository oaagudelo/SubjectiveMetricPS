function pair = log_derivative(im,itr_shift)
    structdis = calculate_mscn_m(im);
    % log derivative paired product coefficients
    shifts = [0 1; 1 0; 1 1; 1 -1];
    shift1 = [-1 0; 0 0; -1 -1];
    shift2 = [1 0; 1 1; 1 1];
    shift3 = [0 -1; 0 1; -1 1];
    shift4 = [0 1; 1 0; 1 -1];
    sign = [-1,1,1];
    
    % calculate log coefficients
    logderdis = log(abs(structdis) + 0.1);
    if itr_shift <= 4
        % circular shift to log coefficients to calculate first 4 log
        % derivative coefficients
        shifted_logderdis = circshift(logderdis,shifts(itr_shift,:));
        % calculate log derivative coefficients
        pair = shifted_logderdis(:) - logderdis(:);
    else
        % circular shift to log coefficients to calculate last 3 log
        % derivative coefficients
        shifted_logderdis1 = circshift(logderdis,shift1(itr_shift-4,:));
        shifted_logderdis2 = circshift(logderdis,shift2(itr_shift-4,:));
        shifted_logderdis3 = circshift(logderdis,shift3(itr_shift-4,:));
        shifted_logderdis4 = circshift(logderdis,shift4(itr_shift-4,:));
        % calculate log derivative coefficients
        pair = shifted_logderdis1(:) + sign(itr_shift-4).*shifted_logderdis2(:)...
            -shifted_logderdis3(:) -shifted_logderdis4(:);     
    end
end