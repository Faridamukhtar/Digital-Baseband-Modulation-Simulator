function ber_bfsk = run_bfsk_simulation(EbNodB, N)
% Simulate BER vs Eb/No for Coherent BFSK
    ber_bfsk = zeros(size(EbNodB));
    for i = 1:length(EbNodB)
        bits = generate_bits(N);
        symbols = map_bfsk(bits);
        r = awgn_channel(symbols, EbNodB(i), 1);
        bits_hat = demap_bfsk(real(r));
        ber_bfsk(i) = calculate_ber(bits, bits_hat);
    end
end
