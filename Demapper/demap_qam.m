function bits_hat = demap_qam(symbols, M)
    k = log2(M);

    if mod(k, 2) == 0
        Mx = sqrt(M);
        My = sqrt(M);
    else
        Mx = 2^ceil(k/2);
        My = 2^floor(k/2);
    end

    kx = log2(Mx);
    ky = log2(My);

    I_levels_all = 2 * (0:Mx-1) - (Mx - 1);
    Q_levels_all = 2 * (0:My-1) - (My - 1);

    bits_hat = [];

    fprintf('\n--- Demapping QAM Symbols ---\n');
    for i = 1:length(symbols)
        sym = symbols(i);
        I = real(sym);
        Q = imag(sym);

        % Find closest I and Q levels
        [~, I_idx] = min(abs(I_levels_all - I));
        [~, Q_idx] = min(abs(Q_levels_all - Q));

        I_gray = I_idx - 1;
        Q_gray = Q_idx - 1;

        fprintf('Symbol %d: %.2f + %.2fj → I=%d (Gray %d), Q=%d (Gray %d)\n', ...
            i, real(sym), imag(sym), I_levels_all(I_idx), I_gray, Q_levels_all(Q_idx), Q_gray);

        % Convert Gray to binary
        I_bin = gray2bin_scalar(I_gray);
        Q_bin = gray2bin_scalar(Q_gray);

        I_bits = de2bi_local(I_bin, kx);
        Q_bits = de2bi_local(Q_bin, ky);

        bits_hat = [bits_hat, I_bits, Q_bits];
    end
    fprintf('Recovered bitstream:\n'); disp(bits_hat);
end

function b = gray2bin_scalar(g)
    b = g;
    while g > 0
        g = bitshift(g, -1);
        b = bitxor(b, g);
    end
end

function bits = de2bi_local(d, k)
    bits = zeros(1, k);
    for i = 1:k
        bits(i) = bitget(d, k - i + 1);
    end
end
