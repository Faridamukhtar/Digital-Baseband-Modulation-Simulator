% Add project folder and all subfolders to MATLAB path
thisFile = mfilename('fullpath');
projectRoot = fileparts(thisFile);
addpath(genpath(projectRoot));

% clear
clear; clc; clear all;

% ---- Config ----
EbNodB = -2:1:10;
N = 1e5;
modulation = 'mpsk';  % Options: 'bfsk', 'dbpsk', 'mpsk', 'all'
M = 4; % For M-PSK (e.g., QPSK)
% ---- Simulation ----
switch lower(modulation)
    case 'dbpsk'
        ber_dbpsk = run_dbpsk_simulation(EbNodB, N);
        % hFig = plot_ber(EbNodB, {ber_dbpsk}, {'Differential BPSK'}, {'g-d'}, 1.5, 'BER vs Eb/No (DBPSK)');
        hFig= plot_ber_with_theory(EbNodB, {ber_dbpsk},  {'Differential BPSK'}, 'dbpsk', 2, {'g-d'}, 1.5, 'BER vs Eb/No (DBPSK)');

    case 'bfsk'
        ber_bfsk = run_bfsk_simulation(EbNodB, N);
        % hFig = plot_ber(EbNodB, {ber_bfsk}, {'Coherent BFSK'}, {'b-o'}, 1.5, 'BER vs Eb/No (BFSK)');
        hFig = plot_ber_with_theory(EbNodB, {ber_bfsk}, {'Coherent BFSK'}, 'bfsk', 2, {'b-o'}, 1.5, 'BER vs Eb/No (BFSK)');

    case 'mpsk'
        ber_mpsk2 = run_mpsk_simulation(EbNodB, N, 2);
        ber_mpsk4 = run_mpsk_simulation(EbNodB, N, 4);
        ber_mpsk8 = run_mpsk_simulation(EbNodB, N, 8);
        ber_mpsk16 = run_mpsk_simulation(EbNodB, N, 16);
        % hFig = plot_ber(EbNodB, {ber_mpsk}, {sprintf('M-PSK (M = %d)', M)}, {'r-s'}, 1.5, 'BER vs Eb/No (MPSK)');
        % hFig0 = plot_ber_with_theory(EbNodB, {ber_mpsk2}, {'B-PSK'}, 'mpsk', 2, {'b-o'}, 1.5, 'BER vs Eb/No (B-PSK)');
        % hFig1 = plot_ber_with_theory(EbNodB, {ber_mpsk4}, {'Q-PSK'}, 'mpsk', 4, {'b-o'}, 1.5, 'BER vs Eb/No (Q-PSK)');
        % hFig2 = plot_ber_with_theory(EbNodB, {ber_mpsk8}, {'8-PSK'}, 'mpsk', 8, {'b-o'}, 1.5, 'BER vs Eb/No (8-PSK)');
        % hFig3 = plot_ber_with_theory(EbNodB, {ber_mpsk16}, {'16-PSK'}, 'mpsk', 16, {'b-o'}, 1.5, 'BER vs Eb/No (16-PSK)');
        hFig = plot_ber(EbNodB, {ber_mpsk2, ber_mpsk4, ber_mpsk8, ber_mpsk16}, ...
                {sprintf('M-PSK (M = %d)', 2), sprintf('M-PSK (M = %d)', 4), ...
                 sprintf('M-PSK (M = %d)', 8), sprintf('M-PSK (M = %d)', 16)}, ...
                {'b-o', 'r-s', 'g-*', 'm-d', 'c-^', 'k-x'}, 1.5, 'BER Performance Comparison');

    case 'mask'
        ber_mask = run_mask_simulation(EbNodB,N,M);
        %hFig = plot_ber(EbNodB, {ber_mask}, {sprintf('M-ASK (M = %d)', M)}, {'r-s'}, 1.5, 'BER vs Eb/No (MASK)');
        hFig = plot_ber_with_theory(EbNodB, {ber_mask}, {sprintf('M-ASK (M = %d)',M)}, 'mask', M, {'b-o'}, 1.5, 'BER vs Eb/No (M-ASK)');
    case 'mqam'
        ber_mqam = run_qam_simulation(EbNodB,N,M);
        %hFig = plot_ber(EbNodB, {ber_mqam}, {sprintf('M-QAM (M = %d)', M)}, {'r-s'}, 1.5, 'BER vs Eb/No (MQAM)');
        hFig = plot_ber_with_theory(EbNodB, {ber_mqam}, {sprintf('M-QAM (M = %d)',M)}, 'mqam', M, {'b-o'}, 1.5, 'BER vs Eb/No (M-QAM)');
  
    case 'msk'
        ber_msk = run_msk_simulation(EbNodB, N);
        hFig= plot_ber_with_theory(EbNodB, {ber_msk},  {'MSK'}, 'msk', 2, {'g-d'}, 1.5, 'BER vs Eb/No (MSK)');
        %MSK isn't M-ary, it is binary only, we use M=2 for function consistency

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

% % show the BER Plot
% if ~isempty(hFig0)
%     set(hFig0, 'Visible', 'on');
% end
% 
% % show the BER Plot
% if ~isempty(hFig1)
%     set(hFig1, 'Visible', 'on');
% end
% 
% % show the BER Plot
% if ~isempty(hFig2)
%     set(hFig2, 'Visible', 'on');
% end
% 
% % show the BER Plot
% if ~isempty(hFig3)
%     set(hFig3, 'Visible', 'on');
% end
