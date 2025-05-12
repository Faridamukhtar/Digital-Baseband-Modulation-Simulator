function ber_mpsk = run_mpsk_simulation(EbNodB, N, M)
% Simulate BER vs Eb/No for Coherent M-PSK
    ber_mpsk = zeros(size(EbNodB));

    % Select Eb/No index to visualize constellation diagram for
    constellation_EbNo_index = length(EbNodB);
    selected_received = [];
    selected_title = "";

    for i = 1:length(EbNodB)
        bits = generate_bits(N);
        [symbols, ~, k, ~] = map_mpsk(bits, M);
        r = awgn_channel(symbols, EbNodB(i), k);
        bits_hat = demap_mpsk(r, M);
        ber_mpsk(i) = calculate_ber(bits, bits_hat);

        % Store only once for plotting after loop
        if i == constellation_EbNo_index
            selected_received = r;
            selected_title = sprintf('Received %d-PSK Constellation at Eb/No = %d dB', M, EbNodB(i));
        end
    end

    % Plot constellation at selected Eb/No
    hFig = plot_constellation(selected_received, selected_title);
    
    % display the figure
    if ~isempty(hFig)
        set(hFig, 'Visible', 'on');
    end
end
