function ber_dbpsk = run_dbpsk_simulation(EbNodB, N)
% Simulate BER vs Eb/No for Differential BPSK (DBPSK)
    ber_dbpsk = zeros(size(EbNodB));
    k = 1; % 1 bit per symbol for BPSK

    % Select Eb/No index to visualize constellation diagram for
    constellation_EbNo_index = length(EbNodB);
    selected_received = [];
    selected_title = "";

    for i = 1:length(EbNodB)
        bits = generate_bits(N);                   % Generate random bits
        symbols = map_dbpsk(bits);                 % DBPSK modulation
        r = awgn_channel(symbols, EbNodB(i), k);   % Add AWGN
        bits_hat = demap_dbpsk(r);                 % DBPSK demodulation
       
        ber_dbpsk(i) = calculate_ber(bits, bits_hat); % BER calculation

        % Save constellation data
        if i == constellation_EbNo_index
            selected_received = r;
            selected_title = sprintf('Received DBPSK Constellation at Eb/No = %d dB', EbNodB(i));
        end
    end
    
    % Plot constellation
    hFig = plot_constellation(selected_received, selected_title);
    
    if ~isempty(hFig)
        set(hFig, 'Visible', 'on');
    end
end