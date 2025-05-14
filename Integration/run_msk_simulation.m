function ber_msk = run_msk_simulation(EbNodB, N)
%Simulate BER vs Eb/No for MSK


    ber_msk = zeros(size(EbNodB));
    
    % Select Eb/No index for constellation plot
    constellation_EbNo_index = length(EbNodB);
    selected_received = [];
    selected_title = "";
    
    for i = 1:length(EbNodB)
        bits = generate_bits(N);
        symbols = map_msk(bits);
        r = awgn_channel(symbols, EbNodB(i), 1); 
        bits_hat = demap_msk(r);
        ber_msk(i) = calculate_ber(bits, bits_hat);
        
        if i == constellation_EbNo_index
            selected_received = r;
            selected_title = sprintf('Received MSK Constellation at Eb/No = %d dB', EbNodB(i));
        end
    end
    
    % Plot constellation
    hFig = plot_constellation(selected_received, selected_title);
    if ~isempty(hFig)
        set(hFig, 'Visible', 'on');
    end
end