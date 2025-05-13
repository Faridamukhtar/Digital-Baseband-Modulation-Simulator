function symbols = map_qam(bits, M)
    k = log2(M);  % Bits per symbol
    %fprintf('Total bits per symbol (k): %d\n', k);

    if mod(k, 2) == 0
        Mx = sqrt(M);
        My = sqrt(M);
    else
        Mx = 2^ceil(k/2);
        My = 2^floor(k/2);
        if Mx * My ~= M
            error('M must be a power of 2.');
        end
    end

    kx = log2(Mx);
    ky = log2(My);
    %fprintf('kx (I): %d, ky (Q): %d\n', kx, ky);

    % Trim bits
    bits = bits(1:floor(length(bits)/k)*k);
    %fprintf('Trimmed input bits:\n'); disp(bits);

    % Group into k-bit segments
    bit_groups = reshape(bits, k, [])';
    %fprintf('Grouped bits:\n'); disp(bit_groups);

    I_bits = bit_groups(:, 1:kx);
    Q_bits = bit_groups(:, kx+1:end);
    %fprintf('I bits:\n'); disp(I_bits);
    %fprintf('Q bits:\n'); disp(Q_bits);

    I_dec = bi2de_local(I_bits);
    Q_dec = bi2de_local(Q_bits);
    %fprintf('I decimal:\n'); disp(I_dec);
    %fprintf('Q decimal:\n'); disp(Q_dec);

    I_gray = bitxor(I_dec, bitshift(I_dec, -1));
    Q_gray = bitxor(Q_dec, bitshift(Q_dec, -1));
    %fprintf('I Gray:\n'); disp(I_gray);
    %fprintf('Q Gray:\n'); disp(Q_gray);

    I_levels = 2 * I_gray - (Mx - 1);
    Q_levels = 2 * Q_gray - (My - 1);
    %fprintf('I levels:\n'); disp(I_levels);
    %fprintf('Q levels:\n'); disp(Q_levels);

    symbols = I_levels + 1j * Q_levels;
    %fprintf('Mapped QAM symbols:\n'); disp(symbols);
end

function d = bi2de_local(B)
% BI2DE_LOCAL - Converts binary matrix (left-msb) to decimal vector
    k = size(B, 2);
    d = sum(B .* 2.^(k-1:-1:0), 2);
end
