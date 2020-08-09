clc
clear 
close all
[v1,T1,vT1]=xlsread('data1.xlsx');  
x1=v1(:,1);y1=v1(:,2);
plot(smooth(x1),smooth(y1),'b','linewidth',2)
hold on 
[v2,T2,vT2]=xlsread('data2.xlsx');  
x2=v2(:,1);y2=v2(:,2);
plot(smooth(x2),smooth(y2),'r','linewidth',2); grid on;
xlabel('wavelength(nm)');  
ylabel('10^-21 cm^2'); 
legend('abs. cross section','em. cross section')
lamdas=[1525 1530 1532 1535 1540 1545 1550 1552 1555 1560 1565]*10^-09;
segmae=[3.983 4.752 4.364 4.147 3.416 3.24 3.084 3.038 2.945 2.773 2.353]*10^-25;
segmaa=[4.538 4.613 4.244 3.298 2.853 2.57 2.277 2.150 1.960 1.676 1.286]*10^-25;
 
xx=[1 2 3 4 5 6 7 8 9 10];
yy=[1.2012e-03   2.3046e-03   2.8067e-03   3.0078e-03   5.7281e-03...
   5.2235e-03   6.7391e-03   7.1429e-03   6.3348e-03   1.0698e-02];
xi=1:0.01:10;
yi=interp1(xx,yy,xi,'spline');
figure
plot(xi,yi)