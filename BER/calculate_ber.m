function ber = calculate_ber(bits, bits_hat)
% Calculate bit error rate
    L = min(length(bits), length(bits_hat));
    ber = sum(bits(1:L) ~= bits_hat(1:L)) / L;
end