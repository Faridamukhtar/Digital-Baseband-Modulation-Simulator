function noisy = awgn_channel(signal, EbNo, k)
% Add AWGN noise to baseband signal
    N0 = 1 / (10^(EbNo/10)); % assuming Eb = 1
    Eavg = mean(abs(signal).^2);
    noise = sqrt(N0 *Eavg/ (2*k)) * (randn(size(signal)) + 1j*randn(size(signal)));
    noisy = signal + noise;
end
