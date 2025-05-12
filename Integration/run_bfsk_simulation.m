function ber_bfsk = run_bfsk_simulation(EbNodB, N)
% Simulate BER vs Eb/No for Coherent BFSK
    ber_bfsk = zeros(size(EbNodB));

    % Choose which Eb/No index to visualize in constellation diagram
    constellation_EbNo_index = length(EbNodB); % choose last index (least noise)
    selected_received = [];
    selected_title = "";

    for i = 1:length(EbNodB)
        bits = generate_bits(N);
        symbols = map_bfsk(bits);  % could be complex: 1 and -1j, or real: 1 and -1
        r = awgn_channel(symbols, EbNodB(i), 1);
        bits_hat = demap_bfsk(r);
        ber_bfsk(i) = calculate_ber(bits, bits_hat);
        if i == constellation_EbNo_index
            selected_received = r;
            selected_title = sprintf('Received BFSK Constellation at Eb/No = %d dB', EbNodB(i));
        end
    end

    % Plot constellation at selected Eb/No
    if ~isempty(selected_received)
        figure("Name", "BPSK Constellation");
        scatter(real(selected_received), imag(selected_received), 10, 'filled');
        axis equal; grid on;
        title(selected_title);
        xlabel('In-phase (I)');
        ylabel('Quadrature (Q)');
    end
end
