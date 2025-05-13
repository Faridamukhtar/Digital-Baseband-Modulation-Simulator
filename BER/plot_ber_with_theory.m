function hFig = plot_ber_with_theory(EbNodB, ber_data, labels, theory_modType, theory_M, ...
                                    colors, markers, titleStr)
% PLOT_BER_WITH_THEORY - Plots simulated BER and adds theoretical curve
%
% Inputs:
%   EbNodB       - Vector of Eb/No values in dB
%   ber_data     - Cell array of BER data vectors (one per simulation)
%   labels       - Cell array of legend labels for simulations
%   theory_modType - Modulation type for theoretical curve ('BPSK','DBPSK','PSK','QAM')
%   theory_M     - Modulation order (e.g., 2, 4, 16)
%   colors       - Cell array of line colors for simulated curves
%   markers      - Line style or marker
%   titleStr     - Plot title (optional)

    if nargin < 8, titleStr = 'BER Performance'; end
    if nargin < 7 || isempty(markers), markers = '-'; end
    if nargin < 6 || isempty(colors), colors = {'b-', 'r-', 'g-', 'm-', 'k-'}; end

    % Create figure
    hFig = figure('Visible', 'off', 'Name', titleStr);
    hold on;

    % --- Plot Simulated BER ---
    numCurves = length(ber_data);
    for i = 1:numCurves
        semilogy(EbNodB, ber_data{i}, colors{i}, 'DisplayName', labels{i}, 'LineWidth', 1.5);
    end

    % --- Plot Theoretical BER ---
    if ~isempty(theory_modType) 
        try
            ber_theory = get_theoretical_ber(EbNodB, theory_modType, theory_M);
            if(ber_theory ~= 0)
                semilogy(EbNodB, ber_theory, 'k--', 'DisplayName', [theory_modType ' (M=' num2str(theory_M) ') Theory'], 'LineWidth', 1.2);
            end
        catch ME
            warning('Could not plot theoretical BER: %s', ME.message);
        end
    end

    hold off;
    grid on;
    xlabel('Eb/No (dB)');
    ylabel('Bit Error Rate');
    legend('show', 'Location', 'southwest');
    title(titleStr);
    set(gca, 'YScale', 'log');
end