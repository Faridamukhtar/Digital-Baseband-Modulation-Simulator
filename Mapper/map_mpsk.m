function [symbols, M, k, gray] = map_mpsk(bits, M)
% Map bits to M-PSK Gray-coded symbols
% Inputs:
%   bits - Row vector of binary bits
%   M    - Modulation order (e.g., 4 for QPSK)
% Outputs:
%   symbols - Column vector of M-PSK symbols
%   M       - Modulation order
%   k       - Bits per symbol
%   gray    - Gray coded indices
    
    % Calculate bits per symbol
    k = log2(M);
    
    % Ensure we have a multiple of k bits
    bits = bits(1:floor(length(bits)/k)*k); % Trim excess bits
    
    % Reshape bits into groups of k bits
    bit_groups = reshape(bits, k, [])';
    
    % Convert bit groups to decimal indices (0 to M-1)
    indices = bi2de(bit_groups, 'left-msb');
    
    % Binary to Gray conversion: shift right 1 bit and XOR with original
    % This implements the conversion: G = B XOR (B >> 1)
    gray = bitxor(indices, bitshift(indices, -1));
    
    % Generate M-PSK symbols: exp(j*2*pi*gray/M)
    symbols = exp(1j * 2 * pi * gray / M);
end
