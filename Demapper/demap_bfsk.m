function bits_hat = demap_bfsk(received)
% BFSK detection based on real/imaginary
    d0 = abs(received - 1);     % Distance to symbol for bit 0
    d1 = abs(received + 1j);    % Distance to symbol for bit 1
    bits_hat = d1 < d0;         % Closer to -j → bit = 1
end