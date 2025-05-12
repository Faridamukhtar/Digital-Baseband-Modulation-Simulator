function symbols = map_qam(bits, M)
% MAP_QAM - Maps a bitstream to QAM symbols using Gray-coded ASK mapping
% Inputs:
%   bits - Row vector of bits (e.g., [0 1 1 0 ...])
%   M    - Modulation order (e.g., 8, 16, 64)
% Output:
%   symbols - Complex QAM symbols mapped from the input bits

    k = log2(M);  % Total bits per QAM symbol

    if mod(k, 2) == 0
        Mx = sqrt(M);
        My = sqrt(M);
    else
        Mx = 2^ceil(k/2);
        My = 2^floor(k/2);
        if Mx * My ~= M
            error('M must be a power of 2.');
        end
    end

    kx = log2(Mx);
    ky = log2(My);

    % Ensure length(bits) is a multiple of k
    bits = bits(1:floor(length(bits)/k)*k);

    % Reshape into k-bit groups
    bit_groups = reshape(bits, k, [])';

    % Separate into I (kx) and Q (ky) parts
    I_bits = bit_groups(:, 1:kx);
    Q_bits = bit_groups(:, kx+1:end);

    % Convert to decimal
    I_dec = bi2de(I_bits,'left-msb');
    Q_dec = bi2de(Q_bits,'left-msb');

    % Convert to Gray code
    I_gray = bitxor(I_dec, bitshift(I_dec, -1));
    Q_gray = bitxor(Q_dec, bitshift(Q_dec, -1));

    % Map to ASK levels: 2*gray - (2M - 1)
    I_levels = 2 * I_gray - (Mx - 1);
    Q_levels = 2 * Q_gray - (My - 1);

    % Combine into complex QAM symbol
    symbols = I_levels + 1j * Q_levels;
end


