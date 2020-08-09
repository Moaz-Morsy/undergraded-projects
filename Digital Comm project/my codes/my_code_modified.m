clc
clear 
close all
%set(0,'DefaultFigureVisible','off');
%M = 512; % # of symbols
m = 9; % #of bits/symbol
n = 4608; % #of bits
M = n/m;
% generating stream of bits:
data=randi([0 1],n,1);
%%stem(data);
% convert stream of bits to digital signal:
bp = 1e-06; % bit period
bit = []; % empty array
for i=1:1:length(data)
    if data(i)== 1;
        sett=ones(1,100);
    else data(i)= 0;
        sett=zeros(1,100);
    end
    bit =[bit sett]; 
end
tb = bp/100:bp/100:length(data)*bp ;
%%plot(tb,bit)
% convert stream of bits to symbolic form:
x=length(data);
 data_symbol = reshape (data,x/m,m);
 for j=1:1:M
     for k=1:1:m
         s(j,k)= num2str(data_symbol(j,k)); % stream of bits to string
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
for v = 1:1:M
   for vv = 1:1:M
      if S(v) == vv-1
          p = [p con(vv)];
      end
   end
end 
%scatterplot(p),grid on;
%title('constellation diagram for 512 QAM p');
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
   snr1 = 10; % signal to noise ratio in dB
    noise1 = awgn(p,snr1,'measured'); % awgn effect 
        %h = scatterplot (noise1);
        %grid
figure
 plot(real(noise1),imag(noise1),'.'); grid on ;
    title('consttelation diagram for 512 QAM with AWGN');

        
    snr2 = 10; 
    noise2 = awgn(p,snr2,'measured');  
        %h = scatterplot (noise);
figure
        plot(real(noise2),imag(noise2),'.'); grid on ;
  title('consttelation diagram for 512 QAM with AWGN');

      snr3 = 5; 
    noise3 = awgn(p,snr3,'measured'); 
       % h = scatterplot (noise);
        %grid
figure
plot(real(noise3),imag(noise3),'.'); grid on ;
  title('consttelation diagram for 512 QAM with AWGN');

      snr4 = 0; 
    noise4 = awgn(p,snr4,'measured');
        %h = scatterplot (noise);
        %grid
figure
plot(real(noise4),imag(noise4),'.'); grid on ;
  title('consttelation diagram for 512 QAM with AWGN');

            snr5 = -3; 
    noise5 = awgn(p,snr5,'measured'); 
        %h = scatterplot (noise);
        %grid
figure
plot(real(noise5),imag(noise5),'.'); grid on ;
  title('consttelation diagram for 512 QAM with AWGN');
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
cii= -24:2:23;
bii= -24:2:23;
con_phii=cii+1i*bii;
con2=[];
for iii=1:1:24
     for jj=1:1:24
         con3(jj)=cii(iii)+1i*bii(jj);
     end
     con2=[con2 con3];
 end
 %constellation1=int16(con2);
%noise=[noise1 noise2 noise3 noise4 noise5];
SS1=[];%empty array
for kkk1=M:-1:1
  if (real(noise1(kkk1)))> 0
      if (imag(noise1(kkk1)))> 0
        for u11=2:2:24
          if (real(noise1(kkk1))<u11)
            if (imag(noise1(kkk1))<u11)
            SS1=[SS1 S(kkk1)]; 
            end  
          end
        end
      elseif (imag(noise1(kkk1)))< 0
        for u11=2:2:24
          if (real(noise1(kkk1))>u11)
            if (imag(noise1(kkk1))<(-u11))
            SS1=[SS1 S(kkk1)]; 
            end   
          end
        end
      else 
            %pp=[pp noise1(kkk)];
      end
  elseif (real(noise1(kkk1)))< 0
      if (imag(noise1(kkk1)))> 0
        for u22=-2:-2:-24
          if (real(noise1(kkk1))>u22)
             if(imag(noise1(kkk1))>(-u22))
            SS1=[SS1 S(kkk1)]; 
             end   
          end
        end
      elseif (imag(noise1(kkk1)))< 0
        for u22=-2:-2:-24
          if (real(noise1(kkk1))>u22)
            if (imag(noise1(kkk1))>u22)
            SS1=[SS1 S(kkk1)];
            end   
          end
        end
      else 
            %pp=[pp noise1(kkk)];
      end
  else
     SS1=[SS1 S(kkk1)];   
  end
end
ss1=dec2bin(SS1');
for jo1=1:1:M
     for ko1=1:1:m
       data_symbol_o1(jo1,ko1)= str2num(ss1(jo1,ko1)); % stream of bits to string
     end
 end
data_o1 = reshape(data_symbol_o1,n,1);
ber1=0;
for i=1:length(data)
    if data(i)~=data_o1(i)
        ber1=ber1+1;
    end
end
BER1=ber1/n;
