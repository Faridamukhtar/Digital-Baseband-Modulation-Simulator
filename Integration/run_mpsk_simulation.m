function ber_mpsk = run_mpsk_simulation(EbNodB, N, M)
% Simulate BER vs Eb/No for Coherent M-PSK
    ber_mpsk = zeros(size(EbNodB));
    for i = 1:length(EbNodB)
        bits = generate_bits(N);
        [symbols, ~, k, ~] = map_mpsk(bits, M);
        r = awgn_channel(symbols, EbNodB(i), k);
        bits_hat = demap_mpsk(r, M);
        ber_mpsk(i) = calculate_ber(bits, bits_hat);
    end
end
