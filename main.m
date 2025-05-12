% Add project folder and all subfolders to MATLAB path
thisFile = mfilename('fullpath');
projectRoot = fileparts(thisFile);
addpath(genpath(projectRoot));

% clear
clear; clc;

% ---- Config ----
EbNodB = -2:1:10;
N = 10e5;
modulation = 'mpsk';  % Options: 'bfsk', 'mpsk', 'both'
M = 4; % For M-PSK (e.g., QPSK)

% ---- Simulation ----
switch lower(modulation)
    case 'bfsk'
        ber_bfsk = run_bfsk_simulation(EbNodB, N);
        semilogy(EbNodB, ber_bfsk, 'b-o', 'LineWidth', 1.5);
        legend('Coherent BFSK');

    case 'mpsk'
        ber_mpsk = run_mpsk_simulation(EbNodB, N, M);
        semilogy(EbNodB, ber_mpsk, 'r-s', 'LineWidth', 1.5);
        legend(sprintf('M-PSK (M = %d)', M));

    case 'both'
        ber_bfsk = run_bfsk_simulation(EbNodB, N);
        ber_mpsk = run_mpsk_simulation(EbNodB, N, M);
        semilogy(EbNodB, ber_bfsk, 'b-o', EbNodB, ber_mpsk, 'r-s', 'LineWidth', 1.5);
        legend('Coherent BFSK', sprintf('M-PSK (M = %d)', M));

    otherwise
        error('Invalid modulation type selected.');
end

% ---- Plot Formatting ----
grid on;
xlabel('Eb/No (dB)');
ylabel('Bit Error Rate');
title('BER Performance Comparison');
