function symbols = map_msk(bits)
% Map bits to MSK symbols with Gray phase encoding

    N = length(bits);
    symbols = zeros(N, 1);
    phase = 0; % Initial phase
    
    % Gray mapping: 
    for i = 1:N
        % Apply phase change based on bit value
        phase_change = (2*bits(i) - 1) * pi/2; % -π/2 for 0, +π/2 for 1
        phase = phase + phase_change;
        
        % Wrap phase to [-π, π]
        phase = mod(phase + pi, 2*pi) - pi;
        
        % Baseband equivalent symbol
        symbols(i) = exp(1j*phase);
    end
end