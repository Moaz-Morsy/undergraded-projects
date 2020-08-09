clc
clear 
close all
r=5e-06;
gammap=0.4;
gammas=0.8;
N=1e25;
A=pi.*r^2;
lamdap=1480e-09;
segmaep=0.7899e-25;
segmaap=1.950e-25;
lamdas=1550e-09;
segmaes=3.084e-25;
segmaas=2.277e-25;
t=10e-03;
c=3e8;
h=6.626e-34;
deltalamda=0.1e-09;
%% The absorption and emission cross section using plot digitizer:
[v1,T1,vT1]=xlsread('data1.xlsx');  
x1=v1(:,1);y1=v1(:,2);
[v2,T2,vT2]=xlsread('data2.xlsx');  
x2=v2(:,1);y2=v2(:,2);

xx1=x1(65:1:115).*10^-9;
yy1=y1(65:1:115).*10^-25;
[xx1,index1] = unique(xx1);
lamda1=(1525:0.1:1565)*10^-9;
segme=interp1(xx1,yy1(index1),lamda1,'spline');
xx2=x2(66:1:115).*10^-9;
yy2=y2(66:1:115).*10^-25;
[xx2,index2] = unique(xx2);
lamda1=(1525:0.1:1565)*10^-9;
segma=interp1(xx2,yy2(index2),lamda1,'spline');

figure
plot(smooth(x1),smooth(y1),'b','linewidth',2)
hold on 
plot(smooth(x2),smooth(y2),'r','linewidth',2); grid on;
xlabel('wavelength(nm)');  
ylabel('10^-21 cm^2'); 
legend('abs. cross section','em. cross section')
title('The absorption and emission cross section using plot digitizer')
%% Ppump and Psout Vs fiber length at wavelength 1550 nm:
psindB=-40:10:10;
psin=10.^(psindB./10)*10^-3;
Ppump_in=[0.5 0.001];
[l,p]=ode45('dP_dz',(0:50),Ppump_in);
[maxValue,maxIndex]=max(p(:,2));
[maxValuep,maxIndexp]=max(10*log10(p(:,2)./0.001));
figure
plot(l,p(:,1),'linewidth',1.5);
hold on
plot(l,p(:,2),'linewidth',1.5);
xlabel('fiber length(m)');  
ylabel('optical powers(W)'); 
legend('Ppump','Psout')
title('Ppump and Psout Vs fiber length at wavelength 1550 nm')
%% Gain Vs fiber length at different pump power:
ppump=0.1:0.1:0.5;
figure
hold on
for j=1:1:length(ppump)
Ppump_in=[ppump(j) 0.001];
[l,p]=ode45('dP_dz',(0:50),Ppump_in);
gainp=(p(:,2)./0.001);
gainpdB=10*log10(gainp);
plot(smooth(l),smooth(gainpdB),'linewidth',1.5)
end
optlength=l(maxIndexp);
plot(optlength,maxValuep,'*','linewidth',1.5)
hold off
xlabel('fiber length(m)');  
ylabel('Gain(dB)'); 
legend('Ppump=0.1','Ppump=0.2','Ppump=0.3',...
'Ppump=0.4','Ppump=0.5','opt.length=15.8811 m')
title('Gain Vs fiber length at different pump power')
%%
%G=p(:,2)./0.001;
%GindB=10*log10(G);
%[maxValueg,maxIndexl]=max(G);
%[maxValue,maxIndex]=max(GindB);
%optlength=l(maxIndex);
%figure
%plot(smooth(l),smooth(GindB),'linewidth',1.5);
%hold on
%plot(optlength,maxValue,'*','linewidth',1.5)
%Ppump_in=[0.4 0.001];
%[l,p4]=ode45('dP_dz',(0:50),Ppump_in);
%G4=p4(:,2)./0.001;
%G4indB=10*log10(G4);
%hold on
%plot(smooth(l),smooth(G4indB),'linewidth',1.5);
%Ppump_in=[0.3 0.001];
%[l,p3]=ode45('dP_dz',(0:50),Ppump_in);
%G3=p3(:,2)./0.001;
%G3indB=10*log10(G3);
%hold on
%plot(smooth(l),smooth(G3indB),'linewidth',1.5);
%Ppump_in=[0.2 0.001];
%[l,p2]=ode45('dP_dz',(0:50),Ppump_in);
%G2=p2(:,2)./0.001;
%G2indB=10*log10(G2);
%hold on
%plot(smooth(l),smooth(G2indB),'linewidth',1.5);
%5Ppump_in=[0.1 0.001];
%[l,p1]=ode45('dP_dz',(0:50),Ppump_in);
%G1=p1(:,2)./0.001;
%G1indB=10*log10(G1);
%hold on
%plot(smooth(l),smooth(G1indB),'linewidth',1.5);
%xlabel('fiber length(m)');  
%ylabel('Gain(dB)'); 
%legend('Ppump=0.5','opt.length=15.8811 m','Ppump=0.4','Ppump=0.3',...
%'Ppump=0.2','Ppump=0.1')
%%
%Psout=p(:,2);
%Psout=Psout(1:1:maxIndex);
%gain=G(1:1:maxIndex);
%Gopt=10.^(maxValue./10);
%Psin=Psout./Gopt;
%[maxValue1]=max(Psout);
%[minValue1]=min(Psout);
%[maxValue2]=max(Psin);
%[minValue2]=min(Psin);
%Psat=((lamdap.*0.5)./lamdas)./(Gopt-1);
%v1=[minIndex1 Psat maxIndex1];
%v2=[minValue1 maxValue1 maxValue1];
%figure
%semilogy(smooth(Psin),smooth(Psout),'linewidth',1.5)
%hold on
%semilogy([minValue2,minValue1],[Psat,maxValue1],'linestyle','--','linewidth',1.5) 
%semilogy(Psat.*0.1,maxValue1,'*','linewidth',1.5)
%xlabel('Psin(W)');  
%ylabel('Psout(W)');
%% Psout Vs Psin & Gain Vs Psin:
psindB=-40:1:40;
psin=10.^(psindB./10)*10^-3;
psout=[];
Gain=[];
for i=1:1:length(psin)
Ppump_in=[0.5 psin(i)];
[l,p]=ode45('dP_dz',(0:50),Ppump_in);
if psin(i)<= 0.001
psout=[psout max(p(:,2))];
elseif psin(i)> 0.001
psout=[psout p(maxIndex,2)];
else
end
psoutdB=10*log10(psout);
Gain=[Gain (psout(i)./psin(i))];
GaindB=10*log10(Gain);
end
figure
semilogy(smooth(psin),smooth(psout),'linewidth',1.5)
xlabel('Psin(w)');  
ylabel('Psout(w)'); 
title('Psout Vs Psin')
ylim([min(psout) max(psout)])
figure
semilogy(smooth(psindB),smooth(GaindB),'linewidth',1.5)
xlabel('Psin(w)');  
ylabel('Gain(dB)'); 
title('Gain Vs Psin')
%% Gain Vs lamda(C-band) at Ppump= 0.5w and Psin= 1mw :
[v,T,vT]=xlsread('abs_em_values.xlsx');  
x=v(:,1);y=v(:,3); z=v(:,2); 
Ppump_in=[0.5 0.001];
gains=[];
lamda=x;
segmae=y;
segmaa=z;
pnoise=[];
for n=1:1:length(x)
[l,ps] = ode45(@(l,ps) dP_dzs(l,ps,x(n),y(n),z(n),lamda,segmae,segmaa)...
               ,(1:0.05:50),Ppump_in);
gains=[gains max(ps(:,2)./0.001)];
gainsdB=abs(10*log10(gains));
end
%maxgainsdB=[];
%for a=1:1:length(x)
%maxgainsdB=[maxgainsdB gainsdB(maxIndexp,a)];
%end
Lamada=(1525:0.05:1565).*10^-9;
GainsdB=interp1(x,gainsdB,Lamada,'spline');
figure
plot(smooth(Lamada),smooth(GainsdB),'linewidth',1.5)
xlabel('wavelength(nm)');  
ylabel('Gain(dB)'); 
title('Gain Vs lamda(C-band) at Ppump= 0.5w and Psin= 1mw')
%% Psout with ASE Vs lamda(C-band):
pp=zeros(1,401);
pp(251)=0.001;
for n=1:1:length(x)
P=[0.5 pp(n)];
[l,pn] = ode45(@(l,pn) dP_dzn(l,pn,x(n),y(n),z(n),lamda,segmae,segmaa),(1:50),P);
pnoise=[pnoise pn(maxIndexp,2)];
pnoisedB=10*log10(pnoise);
end
figure
loglog(x,pnoisedB,'linewidth',1.5)
xlabel('wavelength(nm)');  
ylabel('Optical power(dBm)'); 
title('Psout with ASE Vs lamda(C-band)')
%% all figures
figure
%psindB=-40:10:10;
%psin=10.^(psindB./10)*10^-3;
Ppump_in=[0.5 0.001];
[l,p]=ode45('dP_dz',(0:50),Ppump_in);
[maxValuep,maxIndexp]=max(10*log10(p(:,2)./0.001));
subplot 331
plot(smooth(x1),smooth(y1),'b','linewidth',2)
hold on 
plot(smooth(x2),smooth(y2),'r','linewidth',2); grid on;
xlabel('wavelength(nm)');  
ylabel('10^-21 cm^2'); 
legend('abs. cross section','em. cross section')
title('The absorption and emission cross section')
subplot 332
plot(l,p(:,1),'linewidth',1.5);
hold on
subplot 332
plot(l,p(:,2),'linewidth',1.5);
xlabel('fiber length(m)');  
ylabel('optical powers(W)'); 
legend('Ppump','Psout')
title('Ppump and Psout Vs fiber length at wavelength 1550 nm')
subplot(3,3,[4,5,6])
ppump=0.1:0.1:0.5;
hold on
for j=1:1:length(ppump)
Ppump_in=[ppump(j) 0.001];
[l,p]=ode45('dP_dz',(0:50),Ppump_in);
gainp=(p(:,2)./0.001);
gainpdB=10*log10(gainp);
plot(smooth(l),smooth(gainpdB),'linewidth',1.5)
end
optlength=l(maxIndexp);
plot(optlength,maxValuep,'*','linewidth',1.5)
hold off
xlabel('fiber length(m)');  
ylabel('Gain(dB)'); 
legend('Ppump=0.1','Ppump=0.2','Ppump=0.3',...
'Ppump=0.4','Ppump=0.5','opt.length=15.8811 m')
title('Gain Vs fiber length at different pump power')
subplot 333
semilogy(smooth(psin),smooth(psout),'linewidth',1.5)
xlabel('Psin(w)');  
ylabel('Psout(w)'); 
title('Psout Vs Psin')
subplot 337
semilogy(smooth(psindB),smooth(GaindB),'linewidth',1.5)
xlabel('Psin(w)');  
ylabel('Gain(dB)'); 
title('Gain Vs Psin')
subplot 338
plot(smooth(Lamada),smooth(GainsdB),'linewidth',1.5)
xlabel('wavelength(nm)');  
ylabel('Gain(dB)'); 
title('Gain Vs lamda(C-band) at Ppump= 0.5w and Psin= 1mw')
subplot 339
loglog(x,pnoisedB,'linewidth',1.5)
xlabel('wavelength(nm)');  
ylabel('Optical power(dBm)'); 
title('Psout with ASE Vs lamda(C-band)')
%% Omae wa mou shindeiru