clc
clear 
close all
r=5e-06;
gammap=0.4;
gammas=0.8;
N=1e25;
lamdap=1480e-09;
lamdas=1550e-09;
A=pi.*r^2;
segmae=3.084e-25;
segmaa=2.277e-25;
t=10e-03;
Pp=0.5;
Pin=1e-03;
c=3e8;
h=6.626e-34;
deltalamda=0.1e-09;
const1=(lamdap.*gammap.*segmae)/(A*h*c);
const2=(lamdap.*gammap.*segmaa)/(A*h*c);
N1=(const2.*Pp.*N)/((1/t)+((const1+const2).*Pp));
N2=N-N1;
%syms n2
%vpasolve((n2/t)+((const1+const2).*Pp.*n2)==(const2.*Pp.*N),n2)
g=(segmae.*N2)-(segmaa.*N1);
lp=(gammap.*Pp.*t*lamdap)/(A*N*h*c);
G=exp(g*lp);
Pout=0.5;
%[t,x]=ode45('func',[0 5],[5 3]);
[l,p]=ode45('edfa',[0 200],Pp);
plot(l,p);
[l,po]=ode45('edfa2',[200 0],Pout);
hold on
plot(l,po);
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