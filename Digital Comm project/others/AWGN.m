%AWGN channel
p_signal= mean(abs(y).^2); % signal power 
% show noise effect on conestellation diagram 
    snr = 30; % signal to noise ratio in dB
    noise = awgn(p,snr,'measured'); % awgn effect 
        h = scatterplot (noise);
        grid
    title('consttelation diagram for 512 QAM with AWGN');

        
    snr = 10; 
    noise = awgn(p,snr,'measured');  
        h = scatterplot (noise);
        grid
  title('consttelation diagram for 512 QAM with AWGN');

      snr = 5; 
    noise = awgn(p,snr,'measured'); 
        h = scatterplot (noise);
        grid
  title('consttelation diagram for 512 QAM with AWGN');

      snr = 0; 
    noise = awgn(p,snr,'measured');
        h = scatterplot (noise);
        grid
  title('consttelation diagram for 512 QAM with AWGN');

            snr = -3; 
    noise = awgn(p,snr,'measured'); 
        h = scatterplot (noise);
        grid
  title('consttelation diagram for 512 QAM with AWGN');