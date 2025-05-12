function bits_hat = demap_mask(received, M)
% DEMAP_MASK - Demaps received M-ASK symbols to bits using Gray decoding
% Inputs:
%   received - Column vector of received ASK symbols (e.g., -15, -13, ...)
%   M        - Modulation order (e.g., 8 for 8-ASK)
% Output:
%   bits_hat - Row vector of recovered binary bits

    % Bits per symbol
    k = log2(M);

    % Generate full Gray code sequence
    binary_indices = 0:M-1;
    gray_indices = bitxor(binary_indices, bitshift(binary_indices, -1));

    % Generate full ASK constellation (same as mapping side)
    mapped_values = 2 * gray_indices - (2*M - 1);

    % Build Gray to binary lookup table
    binary_lookup = zeros(1, M);
    for i = 1:M
        gray_code = gray_indices(i);
        gray_bits = de2bi(gray_code, k, 'left-msb');
        binary_bits = zeros(1, k);
        binary_bits(1) = gray_bits(1);
        for j = 2:k
            binary_bits(j) = mod(binary_bits(j-1) + gray_bits(j), 2);
        end
        binary_value = bi2de(binary_bits, 'left-msb');
        binary_lookup(gray_code + 1) = binary_value;
    end

    % Make sure input is a column vector
    received = received(:);

    % Output bit array
    bits_hat = zeros(1, length(received) * k);

    % Demapping: loop through each received symbol
    for i = 1:length(received)
        % Find closest ASK level
        [~, closest_idx] = min(abs(received(i) - mapped_values));
        
        % Get corresponding Gray code
        gray_code = gray_indices(closest_idx);
        
        % Convert Gray to binary index
        binary_idx = binary_lookup(gray_code + 1);
        
        % Convert binary index to bit group
        bit_group = de2bi(binary_idx, k, 'left-msb');
        
        % Store recovered bits
        bits_hat((i-1)*k + 1:i*k) = bit_group;
    end
end
