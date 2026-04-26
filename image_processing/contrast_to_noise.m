% CONTRAST-TO-NOISE RATIO
% CNR_AB = C_AB/sigma_N = |S_A - S_B|/sigma_N

I = im2double(imread('data/mr_brain.jpg'));

% Define regions
regionA = I(50:100, 50:100);        % object
regionB = I(150:200, 150:200);      % background
noise_region = regionB;             % often same as background

cnr_value = cnr_custom(regionA, regionB, noise_region);

disp(['CNR = ', num2str(cnr_value)]);

function cnr = cnr_custom(regionA, regionB, noise_region)

    % Convert to double
    regionA = double(regionA);
    regionB = double(regionB);
    noise_region = double(noise_region);

    % Compute means
    mu_A = mean(regionA(:));
    mu_B = mean(regionB(:));

    % Estimate noise (std)
    sigma_N = std(noise_region(:));

    % Avoid division by zero
    if sigma_N == 0
        cnr = Inf;
    else
        cnr = abs(mu_A - mu_B) / sigma_N;
    end
end
