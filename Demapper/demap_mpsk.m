function bits_hat = demap_mpsk(received, M)
    % DEMAP_MPSK - Demaps received M-PSK symbols to bits using Gray decoding
    % Inputs:
    %   received - Column vector of received M-PSK symbols
    %   M        - Modulation order (e.g., 4 for QPSK)
    % Output:
    %   bits_hat - Recovered row vector of binary bits

    % Calculate bits per symbol
    k = log2(M);  % Bits per symbol

    % Binary to Gray code mapping
    binary_indices = 0:M-1;
    gray_indices = bitxor(binary_indices, bitshift(binary_indices, -1));

    % Precompute Gray-to-Binary lookup table
    binary_lookup = zeros(1, M);
    gray_bit_table = zeros(M, k); % Precompute binary bits
    for i = 1:M
        g = gray_indices(i);
        gray_bits = de2bi(g, k, 'left-msb');
        binary_bits = zeros(1, k);
        binary_bits(1) = gray_bits(1);
        for j = 2:k
            binary_bits(j) = mod(binary_bits(j-1) + gray_bits(j), 2);
        end
        b_val = bi2de(binary_bits, 'left-msb');
        binary_lookup(g+1) = b_val;
        gray_bit_table(g+1, :) = binary_bits; % store directly
    end

    % Generate and reorder M-PSK constellation
    constellation = exp(1j * 2 * pi * (0:M-1) / M);
    constellation = constellation(gray_indices + 1);

    % Ensure received is a column
    received = received(:);

    % Compute distances vectorized: matrix of size (length(received) x M)
    distances = abs(received - reshape(constellation, 1, []));
    [~, closest_indices] = min(distances, [], 2);

    % Fetch Gray indices and lookup corresponding binary bits
    gray_codes = gray_indices(closest_indices);
    bits_group = gray_bit_table(gray_codes + 1, :);

    % Reshape to flat row vector
    bits_hat = reshape(bits_group.', 1, []);
end