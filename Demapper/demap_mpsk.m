function bits_hat = demap_mpsk(received, M)
    % DEMAP_MPSK - Demaps received M-PSK symbols to bits using Gray decoding
    % Inputs:
    %   received - Column vector of received M-PSK symbols
    %   M        - Modulation order (e.g., 4 for QPSK)
    % Output:
    %   bits_hat - Recovered row vector of binary bits

    % Calculate bits per symbol
    k = log2(M);

    % Generate the constellation points with Gray coding
    binary_indices = 0:M-1;
    % Binary to Gray conversion
    gray_indices = bitxor(binary_indices, bitshift(binary_indices, -1));
    
    % Create the inverse mapping (Gray to binary)
    % We need to map each Gray code back to its binary equivalent
    binary_lookup = zeros(1, M);
    for i = 1:M
        gray_code = gray_indices(i);
        % Convert Gray to binary using cumulative XOR approach
        % This implements: B = G(0) ⊕ G(1) ⊕ G(2) ⊕ ... ⊕ G(n)
        gray_bits = de2bi(gray_code, k, 'left-msb');
        binary_bits = zeros(1, k);
        binary_bits(1) = gray_bits(1);
        for j = 2:k
            binary_bits(j) = mod(binary_bits(j-1) + gray_bits(j), 2);
        end
        binary_value = bi2de(binary_bits, 'left-msb');
        binary_lookup(gray_code+1) = binary_value;
    end
    
    % Generate M-PSK constellation (same as encoding)
    constellation = exp(1j * 2 * pi * (0:M-1) / M);
    % Reorder constellation according to Gray coding
    constellation = constellation(gray_indices + 1);

    % Ensure that received is a column vector
    received = received(:); 

    % Initialize the bits_hat vector to store the bits for all received symbols
    bits_hat = zeros(1, length(received) * k);

    % Loop through each received symbol
    for i = 1:length(received)
        % Find the closest constellation point for each received symbol
        [~, closest_idx] = min(abs(received(i) - constellation));
        
        % Get the Gray code index
        gray_code = gray_indices(closest_idx);
        
        % Convert Gray to binary using our lookup table
        binary_idx = binary_lookup(gray_code+1);
        
        % Convert binary index to bits
        bit_group = de2bi(binary_idx, k, 'left-msb');
        
        % Store the bits in the appropriate place in the bits_hat vector
        bits_hat((i-1)*k + 1:i*k) = bit_group;
    end
end