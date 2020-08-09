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
%%
[v1,T1,vT1]=xlsread('data1.xlsx');  
x1=v1(:,1);y1=v1(:,2);
figure
plot(smooth(x1),smooth(y1),'b','linewidth',2)
hold on 
[v2,T2,vT2]=xlsread('data2.xlsx');  
x2=v2(:,1);y2=v2(:,2);
plot(smooth(x2),smooth(y2),'r','linewidth',2); grid on;
xlabel('wavelength(nm)');  
ylabel('10^-21 cm^2'); 
legend('abs. cross section','em. cross section')
%%
Ppump_in=[0.5 0.001];
[l,pp]=ode45('dP_dz',[0 50],Ppump_in);
figure
plot(l,pp(:,1),'linewidth',1.5);
hold on
%[l,ps]=ode45('edfa5',[0 50],5*Pin);
%figure
plot(l,pp(:,2),'linewidth',1.5);
xlabel('optical powers(W)');  
ylabel('fiber length(m)'); 
legend('Ppump','Psin')
%%