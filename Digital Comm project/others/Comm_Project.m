clear all;
close all;
clc;

% We will use 512 QAM Modulation
% That means we have 512 symbols and #bits/symbols = log2(512) = 9
% our stream of bits at least will be 512 * 9 = 4608 bit
M = 512; % Number of symbols
m = log2(M); % Number Of bits per symbol 
n_bits = 4608 ; % Defining Number of bits
stream = randi([0, 1], 1,n_bits); % This function generates 4608 random binary values

% Representation of transmitting binary information as digital signal 
x=stream;
bp=.000001; % bit period
bit=[]; % Defining empty array 
% The following for loop convert the stream of bits to a digital signal
for n=1:1:length(x)
if x(n)==1;
se=ones(1,100);
else x(n)==0;
se=zeros(1,100);
end
bit=[bit se];
end
t1=bp/100:bp/100:100*length(x)*(bp/100);
%figure(1)
%subplot(3,1,1);
%plot(t1,bit,'lineWidth',2.5);grid on;
%axis([ 0 bp*length(x) -.5 1.5]);
%ylabel('amplitude(volt)');
%xlabel(' time(sec)');
%title('transmitting information as digital signal');

% binary information convert into symbolic form for M-array QAM modulation
stream_reshape=reshape(stream,log2(M),n_bits/log2(M))'; % Reshape every 9 bits into one vector
for(j=1:1:M)
for(i=1:1:log2(M))
a(j,i)=num2str(stream_reshape(j,i));
end
end
as=bin2dec(a);
ass=as';
%figure(1)
%subplot(3,1,2);
%stem(ass,'Linewidth',2.0);
%title('serial symbol for 512 QAM modulation at transmitter');
%xlabel('n(discrete time)');
%ylabel(' magnitude');

% Mapping for 512 QAM modulation 
x1=[0:M-1];
%p=qammod(ass,M); %constalation design for 512 QAM acording to symbol
%scatterplot(p),grid on;
sym=0:1:M-1; % considerable symbol of 512 QAM, just for scatterplot
pp=qammod(sym,M); %constalation diagram for M-array QAM
scatterplot(pp),grid on;
title('consttelation diagram for 512 QAM');

%512 QAM modulation
RR=real(p)
II=imag(p)
sp=bp*9; %symbol period for 512 QAM
sr=1/sp; % symbol rate
f=sr*2;
t=sp/100:sp/100:sp; % time vector for each transmitted symbol
m=[];
for(k=1:1:length(RR))
yr=RR(k)*cos(2*pi*f*t); % inphase or real component
yim=II(k)*sin(2*pi*f*t); % Quadrature or imagenary component
y=yr+yim;
m=[m y];
end
tt=sp/100:sp/100:sp*length(RR); % time vector for all transmitted symbols
%figure(1);
%subplot(3,1,3);
%plot(tt,m);
%title('waveform for 512 QAM modulation acording to symbolic information');
%xlabel('time(sec)');
%ylabel('amplitude(volt)');