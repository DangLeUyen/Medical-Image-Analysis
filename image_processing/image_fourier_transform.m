% Image Fourier Transform using fft2 function

% Read the image
I = imread("data/mr_brain.jpg");
imshow(I);

I = im2double(I);

% Convert to grayscale if RGB
if size(I,3) == 3
    I = rgb2gray(I);
end

% Compute 2D FFT
F = fft2(I);

% Shift zero frequency to center
F_shift = fftshift(F);

% Magnitude spectrum
magnitude = log(1 + abs(F_shift));

% Display
figure;
subplot(1,2,1);
imshow(I);
title('Original Image');

subplot(1,2,2);
imshow(magnitude, []);
title('Fourier Spectrum');

% -----------------------------------

% Reconstructing image
reconstructed = ifft2(F);

imshow(real(reconstructed), []);
title('Reconstructed Image');
