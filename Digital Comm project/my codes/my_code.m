clc
clear 
close all
%set(0,'DefaultFigureVisible','off');
%n=9000;
%m=3;
%x='Desired order(M)= ';
M =512; ...input(x); % # of symbols
lamda=ceil(sqrt(M));
if mod(lamda,2)==0
lamda=lamda+1;
else
end
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
 %data_symbol =data_symbol(:);
 %data_symbol =data_symbol';
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
ci= -lamda:2:lamda;
bi= -lamda:2:lamda;
con_phi=ci+1i*bi;
con=[];
 for ii=1:length(ci)
     for j=1:length(ci)
         con1(j)=ci(ii)+1i*bi(j);
     end
     con=[con con1];
 end
p =[]; % Defining empty array 
% mapping symbols to general constellation
for v = 1:1:M
   for vv = 1:1:M
      if S(v) == vv-1
          p = [p con(vv)];
      end
   end
end 
scatterplot(p),grid on;
title('constellation diagram for 512 QAM');
scatterplot(con),grid on;
title('constellation diagram for 512 QAM');
%512 QAM modulation
figure
plot(real(p),imag(p),'.'); grid on;
title('constellation diagram for 512 QAM');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%AWGN channel
% show noise effect on conestellation diagram
   snr = -5; % signal to noise ratio in dB
    noise1 = awgn(p,snr,'measured'); % awgn effect 
        h = scatterplot (noise1);
        grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%noise1=[];
%EbNoindB=-10:5:20;
%for rr=1:1:7
%noise=awgn(p,EbNoindB(rr),'measured');
%noise1=[noise1 noise];
%end
%noise2 = num2cell(reshape(noise1,512,7),1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EbNo=-20;
noise1=awgn(p,EbNo,'measured');
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cii= -(lamda+1):2:(lamda+1);
bii= -(lamda+1):2:(lamda+1);
cii = cii(cii~=0);
bii = bii(bii~=0);
con_phii=cii+1i*bii;
con2=[];
for iii=1:length(ci)
     for jj=1:length(ci)
         con3(jj)=cii(iii)+1i*bii(jj);
     end
     con2=[con2 con3];
end
pp=[];%empty array
for c = 1:1:M
   for cc = 1:1:M
      if S(c) == cc-1
          pp = [pp con2(cc)];
      end
   end
end 
%ppp=[pp pp pp pp pp pp pp];
SS=zeros(size(noise1)); 
for kkk=1:1:M
  if (real(noise1(kkk))> 0) && (imag(noise1(kkk))> 0)
        for mu11=2:2:(lamda+1)
         if (real(noise1(kkk))<mu11)
            for mu21=2:2:(lamda+1)
               if (imag(noise1(kkk))<mu21)
                 for e=1:1:M
                 if abs(noise1(kkk))<=abs(pp(e))&&...
                    abs(mu11+1i*mu21)==abs(pp(e))
                       %SS(kkk)=e-1;
                       %SS(e)=kkk-1;
                        SS(kkk)=S(e);
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
        for mu12=2:2:(lamda+1)
          if (real(noise1(kkk))<mu12)
           for mu22=-2:-2:-(lamda+1)
               if (imag(noise1(kkk))>mu22)
                       for e=1:1:M
                       if abs(noise1(kkk))<=abs(pp(e))&&...
                          abs(mu12+1i*mu22)==abs(pp(e))
                        %SS(kkk)=e-1;
                        %SS(e)=kkk-1;
                        SS(e)=S(e);
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
          for mu13=-2:-2:-(lamda+1)
               if (real(noise1(kkk))>mu13)
               for mu23=2:2:(lamda+1)
               if (imag(noise1(kkk))<mu23)
                       for e=1:1:M
                       if abs(noise1(kkk))<=abs(pp(e))&&...
                          abs(mu13+1i*mu23)==abs(pp(e))
                       %SS(kkk)=e-1;
                       %SS(e)=kkk-1;
                        SS(e)=S(e);
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
          for mu14=-2:-2:-(lamda+1)
          if (real(noise1(kkk))>mu14)
              for mu24=-2:-2:-(lamda+1)
              if (imag(noise1(kkk))>mu24)
              for e=1:1:M
              if abs(noise1(kkk))<=abs(pp(e))&&...
                 abs(mu14+1i*mu24)==abs(pp(e))      
                   %SS(kkk)=e-1;
                   %SS(e)=kkk-1;
                    SS(e)=S(e);
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
EbNoindB=-10:5:20;
ber_total=[1042 430 151 135 78 42 29];
BER=ber_total/n;
semilogy(EbNoindB,BER)
title('the relation between the BER vs. Eb\NoindB');
xlabel('Eb\NoindB');
ylabel('bit_error_rate');
EbNoratio=10.^(EbNoindB/10);
Pe=(4/9)*(1-1/sqrt(M))*(0.5).*erfc(sqrt((3/2)*EbNoratio.*(9/(M-1))));
figure
semilogy(EbNoindB,Pe)
title('the relation between theortical BER vs. Eb\NoindB');
xlabel('Eb\NoindB');
ylabel('bit_error_rate');