function hFig = plot_ber(EbNodB, ber_data, labels, colors, markers, titleStr)
    % PLOT_BER - Returns a figure handle for BER vs Eb/No plot
    if nargin < 6, titleStr = 'BER Performance'; end
    if nargin < 5 || isempty(markers), lineWidth = 1.5; else, lineWidth = markers; end

    hFig = figure('Visible', 'off', 'Name', titleStr);
    hold on;

    for i = 1:length(ber_data)
        semilogy(EbNodB, ber_data{i}, colors{i}, 'LineWidth', lineWidth);
    end

    hold off;
    grid on;
    xlabel('Eb/No (dB)');
    ylabel('Bit Error Rate');
    legend(labels, 'Location', 'southwest');
    title(titleStr);

    % Force Y-axis to logarithmic scale
    set(gca, 'YScale', 'log');
end
