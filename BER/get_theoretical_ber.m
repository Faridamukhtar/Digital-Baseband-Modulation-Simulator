function ber = get_theoretical_ber(EbNoVec, modType, M)
    EbNo = 10.^(EbNoVec / 10);

    switch lower(modType)
        case {'dbpsk'}
            ber = 0.5 * exp(-EbNo);

   
        otherwise
            ber = 0;
            % error('Unsupported modulation type: %s', modType);
    end
end