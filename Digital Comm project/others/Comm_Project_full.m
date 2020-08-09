clear all
close all
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
figure(1)
subplot(3,1,1);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('transmitting information as digital signal');

% binary information convert into symbolic form for M-array QAM modulation
stream_reshape=reshape(stream,log2(M),n_bits/log2(M))'; % Reshape every 9 bits into one vector
for(j=1:1:M)
for(i=1:1:log2(M))
a(j,i)=num2str(stream_reshape(j,i));
end
end
as=bin2dec(a);
ass=as';
figure(1)
subplot(3,1,2);
stem(ass,'Linewidth',2.0);
title('serial symbol for 512 QAM modulation at transmitter');
xlabel('n(discrete time)');
ylabel(' magnitude');

% Mapping for 512 QAM modulation
% define general constalation distribution for 512 QAM starting from 0 to 511
constellation = [-15+17i  -15+19i  -15+21i  -15+23i   -1+23i   -1+21i...
  -1+19i   -1+17i   -1-17i   -1-19i   -1-21i   -1-23i  -15-23i  -15-21i...
  -15-19i  -15-17i  -13+17i  -13+19i  -13+21i  -13+23i   -3+23i   -3+21i...
   -3+19i   -3+17i   -3-17i   -3-19i   -3-21i   -3-23i  -13-23i  -13-21i...
  -13-19i  -13-17i  -11+17i  -11+19i  -11+21i  -11+23i   -5+23i   -5+21i...
   -5+19i   -5+17i   -5-17i   -5-19i   -5-21i   -5-23i  -11-23i  -11-21i...
  -11-19i  -11-17i   -9+17i   -9+19i   -9+21i   -9+23i   -7+23i   -7+21i...
   -7+19i   -7+17i   -7-17i   -7-19i   -7-21i   -7-23i   -9-23i   -9-21i...
   -9-19i   -9-17i  -23+15i  -23+13i  -23+11i   -23+9i   -23+7i   -23+5i...
   -23+3i   -23+1i   -23-1i   -23-3i   -23-5i   -23-7i   -23-9i  -23-11i...
  -23-13i  -23-15i  -21+15i  -21+13i  -21+11i   -21+9i   -21+7i   -21+5i...
   -21+3i   -21+1i   -21-1i   -21-3i   -21-5i   -21-7i   -21-9i  -21-11i...
  -21-13i  -21-15i  -19+15i  -19+13i  -19+11i   -19+9i   -19+7i   -19+5i...
   -19+3i   -19+1i   -19-1i   -19-3i   -19-5i   -19-7i   -19-9i  -19-11i  -19-13i  -19-15i  -17+15i  -17+13i  -17+11i   -17+9i   -17+7i   -17+5i   -17+3i   -17+1i   -17-1i   -17-3i   -17-5i   -17-7i   -17-9i  -17-11i  -17-13i  -17-15i  -15+15i  -15+13i  -15+11i   -15+9i   -15+7i   -15+5i   -15+3i   -15+1i   -15-1i   -15-3i   -15-5i   -15-7i   -15-9i  -15-11i  -15-13i  -15-15i  -13+15i  -13+13i  -13+11i   -13+9i   -13+7i   -13+5i   -13+3i   -13+1i   -13-1i   -13-3i   -13-5i   -13-7i   -13-9i  -13-11i  -13-13i  -13-15i  -11+15i  -11+13i  -11+11i   -11+9i   -11+7i   -11+5i   -11+3i   -11+1i   -11-1i   -11-3i   -11-5i   -11-7i   -11-9i  -11-11i  -11-13i  -11-15i   -9+15i   -9+13i   -9+11i    -9+9i    -9+7i    -9+5i    -9+3i    -9+1i    -9-1i    -9-3i    -9-5i    -9-7i    -9-9i   -9-11i   -9-13i   -9-15i   -7+15i   -7+13i   -7+11i    -7+9i    -7+7i    -7+5i    -7+3i    -7+1i    -7-1i    -7-3i    -7-5i    -7-7i    -7-9i   -7-11i   -7-13i   -7-15i   -5+15i   -5+13i   -5+11i    -5+9i    -5+7i    -5+5i    -5+3i    -5+1i    -5-1i    -5-3i    -5-5i    -5-7i    -5-9i   -5-11i   -5-13i   -5-15i   -3+15i   -3+13i   -3+11i    -3+9i    -3+7i    -3+5i    -3+3i    -3+1i    -3-1i    -3-3i    -3-5i    -3-7i    -3-9i   -3-11i   -3-13i   -3-15i   -1+15i   -1+13i   -1+11i    -1+9i    -1+7i    -1+5i    -1+3i    -1+1i    -1-1i    -1-3i    -1-5i    -1-7i    -1-9i   -1-11i   -1-13i   -1-15i    1+15i    1+13i    1+11i     1+9i     1+7i     1+5i     1+3i     1+1i     1-1i     1-3i     1-5i     1-7i     1-9i    1-11i    1-13i    1-15i    3+15i    3+13i    3+11i     3+9i     3+7i     3+5i     3+3i     3+1i     3-1i     3-3i     3-5i     3-7i     3-9i    3-11i    3-13i    3-15i    5+15i    5+13i    5+11i     5+9i     5+7i     5+5i     5+3i     5+1i     5-1i     5-3i     5-5i     5-7i     5-9i    5-11i    5-13i    5-15i    7+15i    7+13i    7+11i     7+9i     7+7i     7+5i     7+3i     7+1i     7-1i     7-3i     7-5i     7-7i     7-9i    7-11i    7-13i    7-15i    9+15i    9+13i    9+11i     9+9i     9+7i     9+5i     9+3i     9+1i     9-1i     9-3i     9-5i     9-7i     9-9i    9-11i    9-13i    9-15i   11+15i   11+13i   11+11i    11+9i    11+7i    11+5i    11+3i    11+1i    11-1i    11-3i    11-5i    11-7i    11-9i   11-11i   11-13i   11-15i   13+15i   13+13i   13+11i    13+9i    13+7i    13+5i    13+3i    13+1i    13-1i    13-3i    13-5i    13-7i    13-9i   13-11i   13-13i   13-15i   15+15i   15+13i   15+11i    15+9i    15+7i    15+5i    15+3i    15+1i    15-1i    15-3i    15-5i    15-7i    15-9i   15-11i   15-13i   15-15i   17+15i   17+13i   17+11i    17+9i    17+7i    17+5i    17+3i    17+1i    17-1i    17-3i    17-5i    17-7i    17-9i   17-11i   17-13i   17-15i   19+15i   19+13i   19+11i    19+9i    19+7i    19+5i    19+3i    19+1i    19-1i    19-3i    19-5i    19-7i    19-9i   19-11i   19-13i   19-15i   21+15i   21+13i   21+11i    21+9i    21+7i    21+5i    21+3i    21+1i    21-1i    21-3i    21-5i    21-7i    21-9i   21-11i   21-13i   21-15i   23+15i   23+13i   23+11i    23+9i    23+7i    23+5i    23+3i    23+1i    23-1i    23-3i    23-5i    23-7i    23-9i   23-11i   23-13i   23-15i    9+17i    9+19i    9+21i    9+23i    7+23i    7+21i    7+19i    7+17i    7-17i    7-19i    7-21i    7-23i    9-23i    9-21i    9-19i    9-17i   11+17i   11+19i   11+21i   11+23i    5+23i    5+21i    5+19i    5+17i    5-17i    5-19i    5-21i    5-23i   11-23i   11-21i   11-19i   11-17i   13+17i   13+19i   13+21i   13+23i    3+23i    3+21i    3+19i    3+17i    3-17i    3-19i    3-21i    3-23i   13-23i   13-21i   13-19i   13-17i   15+17i   15+19i   15+21i   15+23i    1+23i    1+21i    1+19i    1+17i    1-17i    1-19i    1-21i    1-23i   15-23i   15-21i   15-19i   15-17i];
p =[]; % Defining empty array 
% mapping symbols to general constellation
for v = 1:1:512
   for vv = 1:1:512
      if ass(v) == vv-1
          p = [p constellation(vv)];
      end
   end
end 
scatterplot(p),grid on;
title('constellation diagram for 512 QAM');
scatterplot(constellation),grid on;
title('constellation diagram for 512 QAM');
% show noise effect on conestellation diagram 
    snr = -30; % signal to noise ratio in dB
    noise1 = awgn(constellation,snr,'measured'); % awgn effect 
        h = scatterplot (noise1);
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

            snr = 30; 
    noise = awgn(p,snr,'measured'); 
        h = scatterplot (noise);
        grid
  title('consttelation diagram for 512 QAM with AWGN');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cii= -24:2:24;
bii= -24:2:24;
cii = cii(cii~=0);
bii = bii(bii~=0);
con_phii=cii+1i*bii;
con2=[];
for iii=1:1:24
     for jj=1:1:24
         con3(jj)=cii(iii)+1i*bii(jj);
     end
     con2=[con2 con3];
end
pp=[];%empty array
for c = 1:1:512
   for cc = 1:1:512
      if ass(c) == cc-1
          pp = [pp con2(cc)];
      end
   end
end 
%%detect symbol
SS=zeros(size(noise1)); 
for kkk=1:1:512
  if (real(noise1(kkk))> 0) && (imag(noise1(kkk))> 0)
        for mu11=2:2:24
         if (real(noise1(kkk))<mu11)
            for mu21=2:2:24
               if (imag(noise1(kkk))<mu21)
                 for e=1:1:512
                 if abs(noise1(kkk))<=abs(pp(e))&&...
                    abs(mu11+1i*mu21)==abs(pp(e))
                        SS(e)=ass(e);
                        %SS(kkk)=e-1;
                        %SS(e)=kkk-1;
                 end
                 end
               if (mu21)<(mu21+2)
               break
               end
               end
             end
            if (mu11)<(mu11+2)
                break
            end
          end
        end
  elseif (real(noise1(kkk))> 0) && (imag(noise1(kkk))< 0)
        for mu12=2:2:24
          if (real(noise1(kkk))<mu12)
           for mu22=-2:-2:-24
               if (imag(noise1(kkk))>mu22)
                       for e=1:1:512
                       if abs(noise1(kkk))<=abs(pp(e))&&...
                          abs(mu12+1i*mu22)==abs(pp(e))
                        SS(e)=ass(e);
                        %SS(kkk)=e-1;
                        %SS(e)=kkk-1;
                       end
                       end
               if (mu22)>(mu22-2)
               break
               end
               end
            end
            if (mu12)<(mu12+2)
                break
            end
          end
        end
  elseif (real(noise1(kkk))< 0) && (imag(noise1(kkk))> 0)
          for mu13=-2:-2:-24
               if (real(noise1(kkk))>mu13)
               for mu23=2:2:24
               if (imag(noise1(kkk))<mu23)
                       for e=1:1:512
                       if abs(noise1(kkk))<=abs(pp(e))&&...
                          abs(mu13+1i*mu23)==abs(pp(e))
                        SS(e)=ass(e);
                        %SS(kkk)=e-1;
                        %SS(e)=kkk-1;
                       end
                       end
               end
               if (mu23)<(mu23+2)
               break
               end
               end
               if (mu13)>(mu13-2)
                break
               end
          end
          end   
  elseif (real(noise1(kkk))< 0) && (imag(noise1(kkk))< 0)
          for mu14=-2:-2:-24
          if (real(noise1(kkk))>mu14)
              for mu24=-2:-2:-24
              if (imag(noise1(kkk))>mu24)
              for e=1:1:512
              if abs(noise1(kkk))<=abs(pp(e))&&...
                 abs(mu14+1i*mu24)==abs(pp(e))      
                        SS(e)=ass(e);
                        %SS(kkk)=e-1;
                        %SS(e)=kkk-1;
               end
               end
               if (mu24)>(mu24-2)
               break
               end
               end
               end
               if (mu14)>(mu14-2)
               break
               end
          end
          end
  else
  end
end
SS1=SS';
ss=dec2bin(SS');
for jo=1:1:M
     for ko=1:1:m
     data_symbol_out(jo,ko)= str2num(ss(jo,ko));% stream of bits to string
     end
 end
data_out = reshape(data_symbol_out,n,1);
ber=0;
for i=1:length(stream)
    if stream(i)~=data_out(i)
        ber=ber+1;
    end
end
EbNoindB=-10:5:20;
BER=[2243 2210 2086 2076 2036 1984 1946];
BER1=BER/n_bits;
semilogy(EbNoindB,BER1)
title('the relation between the BER vs. Eb\NoindB');
xlabel('Eb\NoindB');
ylabel('bit_error_rate');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
EbNoratio=10.^(EbNoindB/10);
q=sqrt(3*9*EbNoratio/(M-1));
PE=(4/9)*(1-1/sqrt(M))*(1/2)*erfc(q/sqrt(2));
figure
semilogy(EbNoindB,PE)
title('the relation between theortical BER vs. Eb\NoindB');
xlabel('Eb\NoindB');
ylabel('bit_error_rate');