# Digital Baseband Modulation Simulator in MATLAB

## Project Overview

This MATLAB-based project simulates a digital communication system using baseband equivalent models. It aims to help students explore various modulation techniques and their performance in Additive White Gaussian Noise (AWGN) channels.

---

## System Architecture

The system simulates the following chain:

1. **Binary Data Source**
2. **Mapper (Modulator)**  
   - Coherent M-PSK  
   - Coherent M-ASK  
   - M-QAM  
   - MSK  
   - Coherent BFSK  
   - Differential BPSK
3. **AWGN Channel**  
4. **Demapper (Demodulator)**  
5. **BER Calculator**

All schemes use Gray coding. Simulations are carried out for a range of Eb/No values from -2 dB to 10 dB. Both simulation and theoretical BER curves are plotted.

---

## Language

- MATLAB

## Output
- Plots of **BER vs. Eb/No** for all modulation schemes
- Overlayed theoretical curves
- Analysis of discrepancies between simulated and theoretical results
- Plots of **block diagram** and **constellation diagram**
