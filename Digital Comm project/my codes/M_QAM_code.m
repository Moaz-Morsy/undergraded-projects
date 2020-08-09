clc
clear 
close all
%set(0,'DefaultFigureVisible','off');
M = 512; % # of symbols
m = log2(M); % #of bits/symbol
n = M*m; % #of bits
%generating stream of bits:
data=randi([0 1],n,1); 
stem(data);
%% convert stream of bits to digital signal:
bp = 1e-06; % bit period
bit = []; % empty array
for kk=1:1:length(data)
    if data(kk)== 1;
        set=ones(1,100);
    else data(kk)= 0;
        set=zeros(1,100);
    end
    bit =[bit set]; 
end
tb = bp/100:bp/100:length(data)*bp ;
plot(tb,bit)
%% convert stream of bits to symbolic form:
 data_symbol = reshape (data,M,m);
 for j=1:1:M
     for k=1:1:m
         s(j,k)= num2str(data_symbol(j,k)); % stream of bits to string
     end
 end
 S=bin2dec(s); % sting of bits to decimal
 sp = 9*(bp/100); %symbol period
 ts = sp:sp:length(data_symbol)*sp ;
 stem(S,'Linewidth',2.0)
 plot(ts,S)
 %% mapping symbols to general constellation
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
conx=[];
for x=1:length(con)
if ((real(con(x))<=15)&&(real(con(x))>0))||...
((imag(con(x))<=15)&&(imag(con(x))>0))
conx=[conx con(x)];
elseif((real(con(x))>=-15)&&(real(con(x))<0))||...
((imag(con(x))<=15)&&(imag(con(x))>0))
conx=[conx con(x)];
elseif((real(con(x))>=-15)&&(real(con(x))<0))||...
((imag(con(x))>=-15)&&(imag(con(x))<0))
conx=[conx con(x)];
elseif((real(con(x))<=15)&&(real(con(x))>0))||...
((imag(con(x))>=-15)&&(imag(con(x))<0))
conx=[conx con(x)];
else
end
end
p =[]; % Defining empty array 
for v = 1:1:512
   for vv = 1:1:512
      if S(v) == vv-1
          p = [p conx(vv)];
      end
   end
end 
scatterplot(p),grid on;
title('constellation diagram for 512 QAM');
scatterplot(conx),grid on;
title('constellation diagram for 512 QAM');
%512 QAM modulation
figure
plot(real(p),imag(p),'.'); grid on;
title('constellation diagram for 512 QAM');
%% AWGN channel show noise effect on conestellation diagram:
snr = 10; % signal to noise ratio in dB
noise = awgn(p,snr,'measured'); % awgn effect 
        h = scatterplot (noise);
        grid
%% relation between the BER vs. Eb/No:
%noise1=[];
%EbNoindB=-10:5:20;
%for rr=1:1:7
%noise=awgn(p,EbNoindB(rr),'measured');
%noise1=[noise1 noise];
%end
%noise2 = num2cell(reshape(noise1,512,7),1);
%%%%%%%%%%%%
EbNo=-25;
noise1=awgn(p,EbNo,'measured');
%% setting threshold:
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
      if S(c) == cc-1
          pp = [pp con2(cc)];
      end
   end
end 
%ppp=[pp pp pp pp pp pp pp];
%% Demapping:
SS=zeros(size(noise1)); 
for kkk=1:1:512
  if (real(noise1(kkk))> 0) && (imag(noise1(kkk))> 0)
        for mu11=2:2:24
         if (real(noise1(kkk))<mu11)
            for mu21=2:2:24
               if (imag(noise1(kkk))<mu21)
                 for e=1:1:512
                 if abs(noise1(kkk))<=abs(con2(e))&&...
                    abs(mu11+1i*mu21)==abs(con2(e))
                       SS(e)=S(e);
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
                       if abs(noise1(kkk))<=abs(con2(e))&&...
                          abs(mu12+1i*mu22)==abs(con2(e))
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
          for mu13=-2:-2:-24
               if (real(noise1(kkk))>mu13)
               for mu23=2:2:24
               if (imag(noise1(kkk))<mu23)
                       for e=1:1:512
                       if abs(noise1(kkk))<=abs(con2(e))&&...
                          abs(mu13+1i*mu23)==abs(con2(e))
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
          for mu14=-2:-2:-24
          if (real(noise1(kkk))>mu14)
              for mu24=-2:-2:-24
              if (imag(noise1(kkk))>mu24)
              for e=1:1:512
              if abs(noise1(kkk))<=abs(con2(e))&&...
                 abs(mu14+1i*mu24)==abs(con2(e))      
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
%% convert stream of bits to symbolic form:
for jo=1:1:M
     for ko=1:1:m
       data_symbol_o(jo,ko)= str2num(ss(jo,ko)); % stream of bits to string
     end
 end
data_o = reshape(data_symbol_o,n,1);
%% calc. bit error rate theortical & practiacl:
ber=0;
for kk=1:length(data)
    if data(kk)~=data_o(kk)
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
%% omae wa mou shindeiru