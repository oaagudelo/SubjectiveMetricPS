function chroma = chromams( MS )
[~,~,~,K] = size(MS);
for k = 1:K
    lab=convertRGBToLAB(MS(:,:,3:-1:1,k));
    % Get the A and B components of the LAB color space.
    A = double(lab(:,:,2));
    B = double(lab(:,:,3));
    % Compute the chroma map.
    chroma(:,:,1,k) = sqrt(A.*A + B.*B);
    lab=convertRGBToLAB(MS(:,:,4:-1:2,k));
    % Get the A and B components of the LAB color space.
    A = double(lab(:,:,2));
    B = double(lab(:,:,3));
    % Compute the chroma map.
    chroma(:,:,2,k) = sqrt(A.*A + B.*B);
end
end

