clear
clc
close all
t = 0:0.001:3;
ka1 = 0.4;
fc = 50;
mt = cos(2*pi*9*t);
ct = cos(2*pi*fc*t);
x = (1+ka1*mt).*ct;
xzp = [x zeros(1,6-3)];
sub plot(2,1,1)
plot (t,x)
sub plot(2,1,2)
plot (0:0.001:6,xzp)
figure