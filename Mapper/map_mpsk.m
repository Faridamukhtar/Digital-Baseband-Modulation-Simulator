function [symbols, M, k, gray] = map_mpsk(bits, M)
% Map bits to M-PSK Gray-coded symbols
    k = log2(M);
    bits = bits(1:floor(length(bits)/k)*k); % Trim excess bits
    bit_groups = reshape(bits, k, [])';
    indices = bi2de(bit_groups, 'left-msb');
    gray = bitxor(indices, floor(indices/2));
    symbols = exp(1j * 2 * pi * gray / M);
end
