function ber = get_theoretical_ber(EbNoVec, modType, M)
    EbNo = 10.^(EbNoVec / 10);

    switch lower(modType)
        case {'dbpsk'}
            ber = 0.5 * exp(-EbNo);
        case {'mask'}  % M-ASK
            k = log2(M);
            factor = sqrt((3 * k * EbNo) ./ (M^2 - 1));
            Ps = 2 * (1 - 1/M) .* 0.5 .* erfc(factor / sqrt(2));
            ber = Ps / k;
        case {'mqam'}  % Square M-QAM
            k = log2(M);                   % Bits per symbol
            factor = sqrt(3 * k ./ (M - 1) .* EbNo);
            ber = (4 / k) * (1 - 1/sqrt(M)) .* 0.5 .* erfc(factor / sqrt(2));
   
        otherwise
            ber = 0;
            % error('Unsupported modulation type: %s', modType);
    end
end
