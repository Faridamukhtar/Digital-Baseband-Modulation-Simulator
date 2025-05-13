function ber = calculate_ber(bits, bits_hat)
% Calculate bit error rate
    L = min(length(bits), length(bits_hat));
    %ber = sum(bits(1:L) ~= bits_hat(1:L)) / L;

    errors =0;
    % Compare each bit using a for loop
    for i = 1:L
        if logical(bits(i)) ~= logical(bits_hat(i))
            errors = errors + 1;
        end
    end

    % Compute BER
    ber = errors / L;
    
end