function bits = demap_dbpsk(symbols)
% Demap Differential BPSK (DBPSK) symbols to bits
% Inputs:
%   symbols  - Row vector of received DBPSK symbols (complex values)
% Outputs:
%   bits     - Column vector of demapped bits (0s and 1s)

    N = length(symbols);
    bits = zeros(N, 1);  % Initialize the output bits vector
 
    prev_symbol = 1 + 0j;   % Initial symbol 
    
    for i = 1:N
        % Calculate phase difference (angle) between current and previous symbol
        phase_diff = angle(symbols(i)) - angle(prev_symbol);
        
        % Normalize the phase difference to be within the range [-pi, pi]
        phase_diff = mod(phase_diff + pi, 2*pi) - pi; %adding pi to ensure -pi and pi will not be mapped to the same value
        
        % Check if phase difference is close to 0 (bit 0) or pi (bit 1)
        if abs(phase_diff) < pi / 2
            bits(i) = 0;  % No phase change
        else
            bits(i) = 1;  % 180° phase shift
        end
        
        % Update previous symbol for the next iteration
        prev_symbol = symbols(i);
    end
end
