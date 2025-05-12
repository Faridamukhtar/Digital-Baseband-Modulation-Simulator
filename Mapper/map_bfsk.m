function symbols = map_bfsk(bits)
% Map bits to BFSK baseband: 0 -> -1, 1 -> +1
    symbols = (bits == 0) + 1j * (bits == 1);
end
