% Add project folder and all subfolders to MATLAB path
thisFile = mfilename('fullpath');
projectRoot = fileparts(thisFile);
addpath(genpath(projectRoot));

% clear
clear; clc; clear all;

% ---- Config ----
EbNodB = -2:1:10;
N = 1e5;
modulation = 'dbpsk';  % Options: 'bfsk', 'dbpsk', 'mpsk', 'all'
M = 4; % For M-PSK (e.g., QPSK)
% ---- Simulation ----
switch lower(modulation)
    case 'dbpsk'
        ber_dbpsk = run_dbpsk_simulation(EbNodB, N);
        % hFig = plot_ber(EbNodB, {ber_dbpsk}, {'Differential BPSK'}, {'g-d'}, 1.5, 'BER vs Eb/No (DBPSK)');
        hFig= plot_ber_with_theory(EbNodB, {ber_dbpsk},  {'Differential BPSK'}, 'dbpsk', 2, {'g-d'}, 1.5, 'BER vs Eb/No (DBPSK)');

    case 'bfsk'
        ber_bfsk = run_bfsk_simulation(EbNodB, N);
        hFig = plot_ber(EbNodB, {ber_bfsk}, {'Coherent BFSK'}, {'b-o'}, 1.5, 'BER vs Eb/No (BFSK)');
        % hFig = plot_ber_with_theory(EbNodB, {ber_bfsk}, {'Coherent BFSK'}, 'bfsk', 2, {'b-o'}, 1.5, 'BER vs Eb/No (BFSK)');

    case 'mpsk'
        ber_mpsk = run_mpsk_simulation(EbNodB, N, M);
        hFig = plot_ber(EbNodB, {ber_mpsk}, {sprintf('M-PSK (M = %d)', M)}, {'r-s'}, 1.5, 'BER vs Eb/No (MPSK)');
    case 'mask'
        ber_mask = run_mask_simulation(EbNodB,N,M);
        hFig = plot_ber(EbNodB, {ber_mask}, {sprintf('M-ASK (M = %d)', M)}, {'r-s'}, 1.5, 'BER vs Eb/No (MASK)');
    case 'mqam'
        ber_mask = run_qam_simulation(EbNodB,N,M);
        hFig = plot_ber(EbNodB, {ber_mask}, {sprintf('M-QAM (M = %d)', M)}, {'r-s'}, 1.5, 'BER vs Eb/No (MQAM)');
 
    case 'all'
        ber_bfsk = run_bfsk_simulation(EbNodB, N);
        ber_mpsk = run_mpsk_simulation(EbNodB, N, M);
        ber_dbpsk = run_dbpsk_simulation(EbNodB, N); 
        hFig = plot_ber(EbNodB, {ber_bfsk, ber_mpsk, ber_dbpsk}, ...
                        {'Coherent BFSK', sprintf('M-PSK (M = %d)', M), 'Differential BPSK'}, ...
                        {'b-o', 'r-s', 'g-d'}, 1.5, 'BER Performance Comparison');                    

    otherwise
        error('Invalid modulation type selected.');
end

% show the BER Plot
if ~isempty(hFig)
    set(hFig, 'Visible', 'on');
end
