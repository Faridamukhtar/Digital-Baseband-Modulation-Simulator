function hFig = plot_constellation(selected_received, selected_title)
    % PLOT_CONSTELLATION - Returns a figure handle for a BPSK/QPSK/PSK constellation plot
    % Inputs:
    %   selected_received - Complex vector of received symbols
    %   selected_title    - Title string for the plot
    % Output:
    %   hFig              - Handle to the created figure (not shown unless explicitly called)

    if isempty(selected_received)
        hFig = [];
        return;
    end

    % Create figure and axes
    hFig = figure('Visible', 'off', 'Name', 'Constellation Plot');  % Don't display yet
    scatter(real(selected_received), imag(selected_received), 10, 'filled');
    axis equal;
    grid on;
    xlabel('In-phase (I)');
    ylabel('Quadrature (Q)');
    title(selected_title);
end
