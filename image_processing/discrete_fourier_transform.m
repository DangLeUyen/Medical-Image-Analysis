% Fourier Transforms: convert a signal from time (or space) domain into the
% frequency domain.
% Forward Fourier transform of a time-domain signal: 
% S(f) = integral from -inf to inf of s(t) * exp(-j*2*pi*f*t) dt
% Inverse Fourier transform: 
% s(f) = integral from -inf to inf of S(f)*exp(+j*2*pi*f*t) df

% Create a sample signal
t = 0:0.001:1;                  % time
f1 = 5; f2 = 20;                % frequencies
signal = sin(2*pi*f1*t) + sin(2*pi*f2*t);

S = dft_custom(signal);

s = idft_custom(S);

% Compare
figure
plot(signal, 'b'); hold on;
plot(real(s), 'r--');
legend('Original', 'Reconstructed');
title('IDFT Reconstruction');

function S = dft_custom(signal)
% Discrete Fourier Transform
%
% Input:
%   signal - 1D signal
%
% Output:
%   S      - DFT result (complex)

    signal = double(signal);
    N = length(signal);
    
    S = zeros(1, N);

    for t = 0:N-1
        for n = 0:N-1
            S(t+1) = S(t+1) + signal(n+1) * exp(-1j * 2 * pi * t * n / N);
        end
    end
end

function s = idft_custom(S)
% Inverse Discrete Fourier Transform
%
% Input: frequency
%
% Output: s - time result

    S = double(S);
    N = length(S);

    s = zeros(1, N);

    for n = 0:N-1
        for k = 0:N-1
            s(n+1) = s(n+1) + S(k+1) * exp(1j * 2 * pi * k * n / N);
        end
        s(n+1) = s(n+1) / N;
    end
end


