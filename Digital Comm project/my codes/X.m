clc
clear 
close all
set(0,'DefaultFigureVisible','off');
M = 512; % # of symbols
m = log2(M); % #of bits/symbol
n = M*m; % #of bits
% generating stream of bits:
data=randi([0 1],n,1); 
%%stem(data);
% convert stream of bits to digital signal:
bp = 1e-06; % bit period
bit = []; % empty array
for i=1:1:length(data)
    if data(i)== 1;
        set=ones(1,100);
    else data(i)= 0;
        set=zeros(1,100);
    end
    bit =[bit set]; 
end
tb = bp/100:bp/100:length(data)*bp ;
%%plot(tb,bit)
% convert stream of bits to symbolic form:
 data_symbol = reshape (data,M,m);
 for j=1:1:M
     for kk=1:1:m
         s(j,kk)= num2str(data_symbol(j,kk)); % stream of bits to string
     end
 end
 S=bin2dec(s); % sting of bits to decimal
 sp = 9*(bp/100); %symbol period
 ts = sp:sp:length(data_symbol)*sp ;
 %stem(S,'Linewidth',2.0)
 %plot(ts,S)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ci= -23:2:23;
bi= -23:2:23;
con_phi=ci+1i*bi;
con=[];
 for ii=1:1:24
     for j=1:1:24
         con1(j)=ci(ii)+1i*bi(j);
     end
     con=[con con1];
 end
 constellation=int16(con);
p =[]; % Defining empty array 
% mapping symbols to general constellation
for v = 1:1:512
   for vv = 1:1:512
      if S(v) == vv-1
          p = [p con(vv)];
      end
   end
end 
%scatterplot(p),grid on;
%title('constellation diagram for 512 QAM');
%scatterplot(constellation),grid on;
%title('constellation diagram for 512 QAM');
%512 QAM modulation
RR=real(p);
II=imag(p);
figure
plot(real(p),imag(p),'.'); grid on;
title('constellation diagram for 512 QAM');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AWGN channel
% show noise effect on conestellation diagram
   snr = 30; % signal to noise ratio in dB
    noise1 = awgn(p,snr,'measured'); % awgn effect 
        %h = scatterplot (noise1);
        %grid
figure
 plot(real(noise1),imag(noise1),'.'); grid on ;
    title('consttelation diagram for 512 QAM with AWGN');

        
    snr = 10; 
    noise2 = awgn(p,snr,'measured');  
        %h = scatterplot (noise);
figure
        plot(real(noise2),imag(noise2),'.'); grid on ;
  title('consttelation diagram for 512 QAM with AWGN');

      snr = 5; 
    noise3 = awgn(p,snr,'measured'); 
       % h = scatterplot (noise);
        %grid
figure
plot(real(noise3),imag(noise3),'.'); grid on ;
  title('consttelation diagram for 512 QAM with AWGN');

      snr = 0; 
    noise4 = awgn(p,snr,'measured');
        %h = scatterplot (noise);
        %grid
figure
plot(real(noise4),imag(noise4),'.'); grid on ;
  title('consttelation diagram for 512 QAM with AWGN');

            snr = -3; 
    noise5 = awgn(p,snr,'measured'); 
        %h = scatterplot (noise);
        %grid
figure
plot(real(noise5),imag(noise5),'.'); grid on ;
  title('consttelation diagram for 512 QAM with AWGN');
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
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
 constellation1=int16(con2);
pp=[];
for c = 1:1:512
   for cc = 1:1:512
      if S(c) == cc-1
          pp = [pp con2(cc)];
      end
   end
end 
SS=[];%empty array
for k=1:1:512
 %for e=1:1:512
  if (real(noise1(k))> 0) && (imag(noise1(k))> 0)
          for e=1:1:512
              if abs(noise1(k))<=abs(pp(e))
                       SS=[SS S(e)];
              end
          end
  elseif (real(noise1(k))> 0) && (imag(noise1(k))< 0)
         for e=1:1:512
              if abs(noise1(k))<=abs(pp(e))
                       SS=[SS S(e)];
              end
          end
  elseif (real(noise1(k))< 0) && (imag(noise1(k))> 0)
          for e=1:1:512
              if abs(noise1(k))<=abs(pp(e))
                       SS=[SS S(e)];
              end
          end
  elseif (real(noise1(k))< 0) && (imag(noise1(k))< 0)
          for e=1:1:512
              if abs(noise1(k))<=abs(pp(e))
                       SS=[SS S(e)];
              end
          end
  else 
  end   
 %end
end
SS1=SS'; 
ss=dec2bin(SS1');
for jo=1:1:M
     for ko=1:1:m
       data_symbol_o(jo,ko)= str2num(ss(jo,ko)); % stream of bits to string
     end
 end
data_o = reshape(data_symbol_o,n,1);
ber=0;
for i=1:length(data)
    if data(i)~=data_o(i)
        ber=ber+1;
    end
end
