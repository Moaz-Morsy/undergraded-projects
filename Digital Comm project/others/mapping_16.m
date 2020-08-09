
                        %%% 16-QAM Modulator and Demodulator Implementation with an AWGN Channel %%%
                       
clc;
clear;
close all;
    %%%% Input Signal %%%%
    % Input is a stream of binary digits of integers 0-15
dec=[0 0 0 0 0 0 0 1 0 0 1 0 0 0 1 1 0 1 0 0 0 1 0 1 0 1 1 0 0 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 1 0 1 1 1 1 0 0 1 1 0 1 1 1 1 0 1 1 1 1]; 
dl=length(dec);
	%%%% Serial To Parallel and 2-to-4 Level Converter %%%%
    sp=[];
    o1=[];
    o2=[];
    clear i;
    for i=1:4:64;
        sp=[dec(1,i:i+3)];  % Serial to Parallel 4-bit Register
        I=sp(1,1);          % Separation of I and Q bits
        Id=sp(1,2);
        Q=sp(1,3);
        Qd=sp(1,4);
    
        if I==0             % Assigning Amplitude levels for I-channel
            if Id==0
                o1=[o1 -3]; % if input is 00, output is -3
            else
                o1=[o1 -1]; % if input is 01, output is -1
            end
        
        else
            if Id==0
                o1=[o1 1]; % if input is 10, output is 1
            else
                o1=[o1 3]; % if input is 11, output is 3
            end
        end
    
        if Q==0             % Assigning Amplitude levels for Q-channel
            if Qd==0
                o2=[o2 -3]; % if input is 00, output is -3
            else
                o2=[o2 -1]; % if input is 01, output is -1
            end
        
        else
            if Qd==0
                o2=[o2 1]; % if input is 10, output is 1
            else
                o2=[o2 3]; % if input is 11, output is 3
            end
        end
    
    clear sp, clear I, clear Id, clear Q, clear Qd; 
    end
