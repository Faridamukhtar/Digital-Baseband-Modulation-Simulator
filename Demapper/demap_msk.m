function bits_hat = demap_msk(received)
% Demap MSK symbols to bits using phase differences

    N = length(received);
    bits_hat = zeros(1, N);
    prev_phase = angle(received(1));
    
    for i = 2:N
        curr_phase = angle(received(i));
        phase_diff = curr_phase - prev_phase;
        
        % Normalize phase difference to [-π, π]
        phase_diff = mod(phase_diff + pi, 2*pi) - pi;
        
        % Decision:
        if phase_diff > 0
            bits_hat(i) = 1;  % +π/2 phase change → bit 1
        else
            bits_hat(i) = 0;  % -π/2 phase change → bit 0
        end
        
        prev_phase = curr_phase;
    end
    
    % Handle first bit (assuming initial phase was 0)
    bits_hat(1) = (angle(received(1)) > 0);
end
