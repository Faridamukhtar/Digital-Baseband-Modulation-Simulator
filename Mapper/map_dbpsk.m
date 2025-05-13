function [symbols, gray] = map_dbpsk(bits)
% Map bits to Differential BPSK (DBPSK) symbols
% Inputs:
%   bits   - Row vector of binary bits (0s and 1s)
% Outputs:
%   symbols - Column vector of complex DBPSK symbols
%   gray    - Differentially encoded bit values (0 → no flip, 1 → flip)

    % Initialize symbol array
    N = length(bits);
    symbols = zeros(N, 1);         % Output symbol vector (differentially encoded data)
    gray = zeros(N, 1);            % Stores differentially encoded phase flips 
    prev_symbol = 1 + 0j;          % Initial symbol (to capture unit magnitude, 0 phase)
                                   % -1 + 0j for 1

    for i = 1:N
        if bits(i) == 0
            curr_symbol = prev_symbol;     % No phase change
            gray(i) = 0;
        else
            curr_symbol = -prev_symbol;    % 180° phase shift
            gray(i) = 1;
        end
        symbols(i) = curr_symbol;
        prev_symbol = curr_symbol;         % Update for next bit
    end
end
