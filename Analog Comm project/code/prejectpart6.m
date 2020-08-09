clear
clc
close all
ts = 0.003;
fs = 1/ts; 
t = 0:ts:3;
ka = 0.4;
fm = 9;
fc = 50;
R = 10^4*4;
C = 10^-6;
mt = cos(2*pi*fm*t);
V = length(mt);
%mt = [mt zeros(1,200)];
ct = cos(2*pi*fc*t);
St = (1+ka*mt).*ct;
N = length(t);
%x = [x zeros(1,200)];
y =(1/3*ts).*fftshift(fft(St));
M = length(y);
df = fs/(V-1);
%df =0.022 ;
f = -fs/2:df:fs/2;
z =(1/3*ts).*fftshift(fft(mt));
envelope = (1+ka*mt);
%Vc = (1+ka1*mt).*(1-(t/RC));
Vct(1) = St(1);
for i=2:length(St)
        if St(i)>Vct(i-1)
        Vct(i)=St(i);
        else
        %Vct(i)= Vct(i-1).*(exp(-ts/(R*C)));
        %Vct(i)= Vct(i-1).*(exp(-ts/(R*C)));
        Vct(i)= Vct(i-1).*(1-(0.003/(R*C)));
        end
end
subplot(6,1,1)
plot(t,mt)
subplot(6,1,2)
plot (t,St)
subplot(6,1,3)
%plot ((0:N-1)/3,abs(y))
plot (f,abs(y))
subplot(6,1,4)
plot(t,St)
hold on
subplot(6,1,4)
plot (t,envelope)
hold on
subplot(6,1,5)
plot(t,St)
hold on
subplot(6,1,5)
%stem(t,St)
hold on
subplot(6,1,5)
plot(t,Vct)
hold on
subplot(6,1,5)
%stem(t,Vct)
subplot(6,1,6)
plot(t,mt)
hold on
plot(t,envelope)
subplot(6,1,6)
hold on
subplot(6,1,6)
plot(t,Vct)
figure
subplot(2,1,1)
plot(t,mt)
subplot(2,1,2)
%plot ((0:length(z)-1),abs(z))
plot (f,abs(z))
figure
subplot(2,1,1)
stem(t,mt)
subplot(2,1,2)
plot(t,St)
hold on
subplot(2,1,2)
stem(t,St)
hold on
subplot(2,1,2)
plot(t,Vct)
figure
subplot(2,1,1)
stem((0:N-1),mt)
subplot(2,1,2)
plot((0:N-1),St)
hold on
subplot(2,1,2)
stem((0:N-1),St)
hold on
subplot(2,1,2)
plot((0:N-1),Vct)