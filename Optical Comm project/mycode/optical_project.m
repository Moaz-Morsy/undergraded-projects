clc
clear 
close all
r=5e-06;
L=50;
gammap=0.4;
gammas=0.8;
N=1e25;
lamdap=1480e-09;
A=pi.*r^2;
lamdas=[1525 1530 1532 1535 1540 1545 1550 1552 1555 1560 1565]*10^-09;
segmae=[3.983 4.752 4.364 4.147 3.416 3.24 3.084 3.038 2.945 2.773 2.353]*10^-25;
segmaa=[4.538 4.613 4.244 3.298 2.853 2.57 2.277 2.150 1.960 1.676 1.286]*10^-25; 
segmae1=0.7899e-25; %@1480 nm
segmaa1=1.950e-25;  %@1480 nm 
t=10e-03;
Ppump=0.5;
Pp=0.1:0.1:0.5;
Pin=1e-03;
c=3e8;
h=6.626e-34;
deltalamda=0.1e-09;
%for i=1:length(lamdas)
%const1=(lamdas(i).*gammas.*segmae(i))/(A*h*c);
%const2=(lamdas(i).*gammas.*segmaa(i))/(A*h*c);
%n2(i)=(const2.*Pin.*N)/((1/t)+((const1+const2).*Pin));
%end
%con1=sum(lamdas.*segmae);
%con2=sum(lamdas.*segmaa);
%const1=(gammas.*con1)/(A*h*c);
%const2=(gammas.*con2)/(A*h*c);
%N2=(const2.*Pin.*N)/((1/t)+((const1+const2).*Pin));
%N1=N-N2;
const1=(lamdap.*gammap.*segmae1)/(A*h*c);
const2=(lamdap.*gammap.*segmaa1)/(A*h*c);
for i=1:length(Pp)
N2(i)=(const2.*Pp(i).*N)/((1/t)+((const1+const2).*Pp(i)));
end
N1=N-N2;
%for j=1:length(N1)
%gg(j)=(segmae(1).*N2(j))-(segmaa(1).*N1(j));
%end
for j=1:length(N1)
    for jj=1:length(lamdas)
gg(j,jj)=(segmae(jj).*N2(j))-(segmaa(jj).*N1(j));
    end
end
g=gg;
lp=(gammap.*Ppump.*t*lamdap)/(A*N*h*c);
len=0:5:50;
leni=0:1:50;
%PsindB=-40:1:0;
lamda=(1525:0.1:1565)*10^-9;
G=exp(g.*L);
GindB=10*log(G);
GindBi=interp1(lamdas,GindB(1,:),lamda,'spline');
figure
plot(smooth(lamdas),smooth(GindB(1,:)))
figure
plot(smooth(lamda),smooth(GindBi),'linewidth',1.5)
GindBi=interp1(len,GindB(1,:),leni,'spline');
figure
plot(smooth(leni),smooth(GindBi),'linewidth',1.5)
xmax1=15;
ymax1=748.8;
hold on
plot(xmax1,ymax1,'*','linewidth',1.5)
GindBi=interp1(len,GindB(2,:),leni,'spline');
hold on
plot(smooth(leni),smooth(GindBi),'linewidth',1.5)
xmax2=5;
ymax2=860.2;
hold on
plot(xmax2,ymax2,'*','linewidth',1.5)
GindBi=interp1(len,GindB(3,:),leni,'spline');
hold on
plot(smooth(leni),smooth(GindBi),'linewidth',1.5)
xmax3=5;
ymax3=909.3;
hold on
plot(xmax3,ymax3,'*','linewidth',1.5)
GindBi=interp1(len,GindB(4,:),leni,'spline');
hold on
plot(smooth(leni),smooth(GindBi),'linewidth',1.5)
xmax4=5;
ymax4=934.4;
hold on
plot(xmax4,ymax4,'*','linewidth',1.5)
GindBi=interp1(len,GindB(5,:),leni,'spline');
hold on
%[maxValue,maxIndex]=max(GindBi);
%maxgain=maxValue;
%pumpinglength=maxIndex;
%ymax=max(GindBi);
%xmax=leni(GindBi==ymax);
plot(smooth(leni),smooth(GindBi),'linewidth',1.5)
%from graph:
xmax5=5;
ymax5=949.6;
hold on
plot(xmax5,ymax5,'*','linewidth',1.5)
legend('0.1','opt.length at maxgain',...
'0.2','opt.length at maxgain','0.3','opt.length at maxgain',...
'0.4','opt.length at maxgain','0.5','opt.length at maxgain')
%%
PsindB=-40:10:0; %input signal in dB
%ymax=[ymax1 ymax2 ymax3 ymax4 ymax5];
PsoutdB=PsindB+ymax5;
Psin=10.^(PsindB/10);
Psout=10.^(PsoutdB/10);
Psini=0:0.025:1;
Psouti=interp1(Psin,Psout,Psini,'spline');
figure
semilogy(smooth(Psini),smooth(Psouti),'linewidth',1.5)
xlabel('Psin');  
ylabel('Psout'); 
%%
lamdasignal=(1525:10:1565)*10^-9;
Gain=1+(lamdap.*Ppump).*((1550*10^-9)*Psin).^-1;
Psini=0:0.0125:1;
Gaini=interp1(Psin,Gain,Psini,'spline');
figure
semilogy(smooth(Psin),smooth(Gain),'linewidth',1.5)
%%
[v1,T1,vT1]=xlsread('data1.xlsx');  
x1=v1(:,1);y1=v1(:,2);
x11=x1((64:0.1:116),1)*10^-9;
[x11,index] = unique(x11);
y11=y1((64:0.1:116),1)*10^-25;
[y11,index] = unique(y11);
lamda1=(1525:0.1:1565)*10^-9;
segme=interp1(x11,y11(index),lamda1,'spline');
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
x=[0.5 0.001];
[l,pp]=ode45('edfa7',[0 50],x);
figure
plot(l,pp(:,1),'linewidth',1.5);
hold on
%[l,ps]=ode45('edfa5',[0 50],5*Pin);
%figure
plot(l,pp(:,2),'linewidth',1.5);
%%
z=0;
zz=0.5;
zzz=1e-03;
lf=[z];
ppf=[zz];
psf=[zzz];
hSTEP=0.1;
n=500;
for w=0:n-1
   z=z+hSTEP;

   k31=hSTEP*feval('edfa4',z,zz);
   m31=hSTEP*feval('edfa5',z,zzz);

   k32=hSTEP*feval('edfa4',(z+0.5*hSTEP),(zz+0.5*k31));
   m32=hSTEP*feval('edfa5',z+0.5*hSTEP,zzz+0.5*m31);

   k33=hSTEP*feval('edfa4',(z+0.5*hSTEP),(zz+0.5*k32));
   m33=hSTEP*feval('edfa5',(z+0.5*hSTEP),(zzz+0.5*m32));

   k34=hSTEP*feval('edfa4',z+hSTEP,zz+k33);
   m34=hSTEP*feval('edfa5',z+hSTEP,zzz+m33);

   zz=zz+(1/6)*(k31+2*(k32+k33)+k34);   % Pump values
   zzz=zzz+(1/6)*(m31+2*(m32+m33)+m34);   % Signal values

   lf=[lf,z];
   ppf=[ppf,zz];
   psf=[psf,zzz];

end
figure
plot(lf,ppf)
hold on
plot(lf,psf)