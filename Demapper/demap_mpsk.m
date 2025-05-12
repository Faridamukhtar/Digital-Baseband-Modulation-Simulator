function bits_hat = demap_mpsk(received, M)
    % DEMAP_MPSK - Demaps received M-PSK symbols to bits using Gray decoding
    % Inputs:
    %   received - Column vector of received M-PSK symbols
    %   M        - Modulation order (e.g., 4 for QPSK)
    % Output:
    %   bits_hat - Recovered row vector of binary bits

    k = log2(M);  % Bits per symbol

    % Standard Gray code lookup table: binary index to Gray code
    binary_indices = 0:M-1;
    gray_indices = bitxor(binary_indices, floor(binary_indices / 2));  % Forward Gray code
    [~, inv_gray] = sort(gray_indices);  % Inverse mapping: gray → binary

    % Generate M-PSK constellation (same as encoding)
    constellation = exp(1j * 2 * pi * gray_indices / M);

    % Ensure that received is a column vector
    received = received(:); 

    % Initialize the bits_hat vector to store the bits for all received symbols
    bits_hat = zeros(1, length(received) * k);

    % Loop through each received symbol
    for i = 1:length(received)
        % Find the closest constellation point for each received symbol
        [~, closest_idx] = min(abs(received(i) - constellation));  % Find closest symbol

        % Map the Gray code index back to binary
        binary_idx = inv_gray(closest_idx);  % Get binary index
        % Convert binary index to bits
        bit_group = de2bi(binary_idx-1, k, 'left-msb');  % Convert to binary bits
        
        % Store the bits in the appropriate place in the bits_hat vector
        bits_hat((i-1)*k + 1:i*k) = bit_group;  % Assign to preallocated space
    end
end
