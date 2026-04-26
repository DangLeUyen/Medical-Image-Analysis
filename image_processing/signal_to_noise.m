% Generate signal and noise
signal = randn(1,1000);
noise = 0.1 * randn(1,1000);
 
% Calculate snr using snr_custom() function which is defined below.
r = snr_custom(signal, noise);
disp(['my SNR = ', num2str(r), ' dB']);

% Using srn() which is built in MATLAB to compare with snr_custom function
r2 = snr(signal,noise);
disp(['built-in SNR = ', num2str(r2), ' dB']);

% Apply snr to medical image
I = imread("data/mr_brain.jpg");
imshow(I);

% Add noise with variance 0.01, 0.05, and 0.1
noisy_I1 = imnoise(I, 'gaussian', 0, 0.01);
noisy_I2 = imnoise(I, 'gaussian', 0, 0.05);
noisy_I3 = imnoise(I, 'gaussian', 0, 0.1);
noisy_images = {noisy_I1, noisy_I2, noisy_I3};

for i = 1:length(noisy_images)
    noisy_I = noisy_images{i};
    
    noise = noisy_I - I;
    r = snr_custom(I, noise);
    
    disp(['SNR of noisy_I', num2str(i), ' = ', num2str(r), ' dB']);
end

% Signal-to-noise function: snr = 10*log_10(signal_power/noise_power) db
function r = snr_custom(signal, noise)

    signal = double(signal);
    noise  = double(noise);

    % Compute power
    signal_power = mean(signal(:).^2);
    noise_power  = mean(noise(:).^2);

    % Avoid division by zero
    if noise_power == 0
        r = Inf;
    else
        r = 10 * log10(signal_power / noise_power);
    end
end
