function [symbols, M, k, gray, mapped_values] = map_mask(bits, M)
% Map bits to M-ASK Gray-coded amplitude levels
% Inputs:
%   bits - Row vector of binary bits
%   M    - Modulation order (e.g., 8 for 8-ASK)
% Outputs:
%   symbols       - Column vector of M-ASK mapped values (amplitudes)
%   M             - Modulation order
%   k             - Bits per symbol
%   gray          - Gray-coded decimal indices
%   mapped_values - Full vector of Gray-coded ASK levels (for reference)

    % Calculate bits per symbol
    k = log2(M);
    
    % Trim bits to be a multiple of k
    bits = bits(1:floor(length(bits)/k)*k);
    
    % Group bits into k-bit chunks
    bit_groups = reshape(bits, k, [])';
    
    % Convert binary to decimal
    indices = de2bi(bit_groups,'left-msb');

    
    % Convert binary to Gray code
    gray = bitxor(indices, bitshift(indices, -1));
    
    % Generate full Gray-coded decimal values (0 to M-1)
    full_gray = bitxor((0:M-1)', bitshift((0:M-1)', -1));
    
    % Apply mapping: level = 2*gray - (M - 1)
    mapped_values = 2*full_gray - (M - 1);
    
    % Map input bits to corresponding ASK symbols
    symbols = mapped_values(gray + 1); % +1 because MATLAB indexing starts at 1

    % Output as column vector
    symbols = symbols(:);
end

