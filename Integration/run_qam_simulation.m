function ber_qam = run_qam_simulation(EbNodB, N, M)
% Simulate BER vs Eb/No for Gray-coded M-QAM
% Inputs:
%   EbNodB - Vector of Eb/No values in dB (e.g., 0:2:20)
%   N      - Number of bits to simulate (e.g., 1e5)
%   M      - Modulation order (e.g., 16, 64, 256 for square QAM)
%
% Output:
%   ber_qam - Bit Error Rate (BER) at each Eb/No point

    ber_qam = zeros(size(EbNodB));

    % Choose Eb/No index to visualize constellation
    constellation_EbNo_index = length(EbNodB);
    selected_received = [];
    selected_title = "";

    for i = 1:length(EbNodB)
        % Generate random bits
        bits = generate_bits(N);

        % Map bits to M-QAM symbols
        symbols = map_qam(bits, M);
        k = log2(M);  % Bits per symbol

        % Pass through AWGN channel (complex noise)
        r = awgn_channel(symbols, EbNodB(i), k);

        % Demap received symbols to bits
        bits_hat = demap_qam(r, M);

        % Compute BER
        ber_qam(i) = calculate_ber(bits(1:length(bits_hat)), bits_hat);

        % Store received symbols for constellation plotting
        if i == constellation_EbNo_index
            selected_received = r;
            selected_title = sprintf('Received %d-QAM Constellation at Eb/No = %d dB', M, EbNodB(i));
        end
    end

    % Plot 2D QAM constellation
    hFig = plot_constellation(selected_received, selected_title);

    if ~isempty(hFig)
        set(hFig, 'Visible', 'on');
    end
end
