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