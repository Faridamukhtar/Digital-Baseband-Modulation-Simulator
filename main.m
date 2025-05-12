% Add project folder and all subfolders to MATLAB path
thisFile = mfilename('fullpath');
projectRoot = fileparts(thisFile);
addpath(genpath(projectRoot));

% clear
clear; clc; clear all;

% ---- Config ----
EbNodB = -2:1:10;
N = 1e5;
modulation = 'all';  % Options: 'bfsk', 'mpsk', 'all'
M = 4; % For M-PSK (e.g., QPSK)
% ---- Simulation ----
switch lower(modulation)
    case 'bfsk'
        ber_bfsk = run_bfsk_simulation(EbNodB, N);
        hFig = plot_ber(EbNodB, {ber_bfsk}, {'Coherent BFSK'}, {'b-o'}, 1.5, 'BER vs Eb/No (BFSK)');

    case 'mpsk'
        ber_mpsk = run_mpsk_simulation(EbNodB, N, M);
        hFig = plot_ber(EbNodB, {ber_mpsk}, {sprintf('M-PSK (M = %d)', M)}, {'r-s'}, 1.5, 'BER vs Eb/No (MPSK)');

    case 'all'
        ber_bfsk = run_bfsk_simulation(EbNodB, N);
        ber_mpsk = run_mpsk_simulation(EbNodB, N, M);
        hFig = plot_ber(EbNodB, {ber_bfsk, ber_mpsk}, ...
                        {'Coherent BFSK', sprintf('M-PSK (M = %d)', M)}, ...
                        {'b-o', 'r-s'}, 1.5, 'BER Performance Comparison');

    otherwise
        error('Invalid modulation type selected.');
end

% show the BER Plot
if ~isempty(hFig)
    set(hFig, 'Visible', 'on');
end
