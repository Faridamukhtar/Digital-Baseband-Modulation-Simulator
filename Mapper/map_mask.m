function [symbols, M, k, gray, ask_levels] = map_mask(bits, M)
    k = log2(M);
    %fprintf('Bits per symbol (k): %d\n', k);

    bits = bits(1:floor(length(bits)/k)*k);
    %fprintf('Trimmed bits:\n'); disp(bits);

    bit_groups = reshape(bits, k, [])';
    %fprintf('Grouped bits:\n'); disp(bit_groups);

    powers = 2.^(k-1:-1:0);
    indices = bit_groups * powers';
    %fprintf('Decimal indices:\n'); disp(indices);

    gray = bitxor(indices, bitshift(indices, -1));
    %fprintf('Gray codes:\n'); disp(gray);

    ask_levels = linspace(-(M-1), M-1, M);  %  for M=8: [-7 -5 -3 -1 1 3 5 7]
    %fprintf('ASK Levels:\n'); disp(ask_levels);

    symbols = ask_levels(gray + 1);  
    %fprintf('Mapped symbols:\n'); disp(symbols);

    symbols = symbols(:);  % Column vector
end
