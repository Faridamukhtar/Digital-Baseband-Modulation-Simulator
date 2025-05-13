function bits_hat = demap_mask(received, M)
    k = log2(M);  
    %disp(['Bits per symbol (k): ', num2str(k)]);

    % Generate full Gray code and corresponding ASK levels
    binary_indices = 0:M-1;
    %disp('Binary indices:');
    %disp(binary_indices);

    gray_indices = bitxor(binary_indices, bitshift(binary_indices, -1));
    %disp('Gray code indices:');
    %disp(gray_indices);

    mapped_values = 2 * gray_indices - (M - 1);
    %disp('Mapped ASK levels (gray-coded):');
    %disp(mapped_values);

    received = received(:);
    %disp('Received ASK symbols:');
    %disp(received);

    bits_hat = zeros(1, length(received) * k);
    %disp(['Preallocated bits_hat (length = ', num2str(length(bits_hat)), '):']);
    %disp(bits_hat);

    for i = 1:length(received)
        %fprintf('\nProcessing symbol %d: %.2f\n', i, received(i));

        % Match symbol to nearest known ASK level
        [~, idx] = min(abs(received(i) - mapped_values));
        %fprintf('  Closest ASK level index: %d (mapped value: %d)\n', idx, mapped_values(idx));

        gray_code = gray_indices(idx);
        %fprintf('  Gray code (decimal): %d\n', gray_code);

        gray_bits = de2bi_local(gray_code, k);
        %fprintf('  Gray code bits: ');
        %disp(gray_bits);

        % Convert Gray to Binary using inline logic
        bin_bits = zeros(1, k);
        bin_bits(1) = gray_bits(1);
        for j = 2:k
            bin_bits(j) = bitxor(bin_bits(j-1), gray_bits(j));
            %fprintf('    bin_bits(%d) = bin_bits(%d) XOR gray_bits(%d) = %d XOR %d = %d\n', ...
                    %j, j-1, j, bin_bits(j-1), gray_bits(j), bin_bits(j));
        end
        %fprintf('  Recovered binary bits: ');
        %disp(bin_bits);

        bits_hat((i-1)*k + 1 : i*k) = bin_bits;
        %fprintf('  bits_hat so far: ');
        %disp(bits_hat);
    end

    %disp('Final recovered bitstream:');
    %disp(bits_hat);
end
