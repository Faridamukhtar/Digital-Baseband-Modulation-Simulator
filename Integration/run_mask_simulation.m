function ber_mask = run_mask_simulation(EbNodB, N, M)

    ber_mask = zeros(size(EbNodB));

    % Choose an Eb/No index to visualize the constellation
    constellation_EbNo_index = length(EbNodB);
    selected_received = [];
    selected_title = "";

    for i = 1:length(EbNodB)
        % Generate random bits
        bits = generate_bits(N);

        % Map bits to M-ASK symbols (gray-coded)
        [symbols, ~, k, ~, ~] = map_mask(bits, M);

        % Pass through AWGN channel
        r = awgn_channel(symbols, EbNodB(i), k);  % Real-valued

        % Demap received signal back to bits
        bits_hat = demap_mask(r, M);

        % Compute Bit Error Rate
        ber_mask(i) = calculate_ber(bits, bits_hat);

        % Store constellation data for plotting
        if i == constellation_EbNo_index
            selected_received = r;
            selected_title = sprintf('Received %d-ASK Constellation at Eb/No = %d dB', M, EbNodB(i));
        end
    end

    % Plot received amplitude constellation at selected Eb/No
    hFig = plot_constellation(selected_received, selected_title);

    if ~isempty(hFig)
        set(hFig, 'Visible', 'on');
    end
end
