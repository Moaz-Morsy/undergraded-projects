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
        Vct(i)= Vct(i-1).*(1-(ts/(R*C)));
        end
end
v =(1/3*ts).*fftshift(fft(Vct));
subplot(6,1,1)
plot(t,mt)
title('the orginal signal'); 
xlabel('time (s)'); 
ylabel('amplitude');
subplot(6,1,2)
plot (t,St)
title('the AM modulated signal'); 
xlabel('time (s)'); 
ylabel('amplitude');
subplot(6,1,3)
plot (f,abs(y))
title('Spectrum of the AM modulated signal'); 
xlabel('frequency (Hz)'); 
ylabel('amplitude');
subplot(6,1,4)
plot(t,St)
hold on
subplot(6,1,4)
plot (t,envelope)
title('Envelope detector output of AM signal "ideal"'); 
xlabel('time (s)'); 
ylabel('amplitude');
legend('St','envelope')
hold on
subplot(6,1,5)
plot(t,St)
hold on
subplot(6,1,5)
plot(t,Vct)
title('Envelope detector output of AM signal "practical"'); 
xlabel('time (s)'); 
ylabel('amplitude');
legend('St','Vct')
subplot(6,1,6)
plot(t,mt)
hold on
%plot(t,envelope)
subplot(6,1,6)
hold on
subplot(6,1,6)
plot(t,Vct)
title('the orginal signal & Envelope detector output of AM signal "practical"'); 
xlabel('time (s)'); 
ylabel('amplitude');
legend('mt','Vct')
figure
subplot(2,1,1)
plot(t,mt)
hold on
subplot(2,1,1)
plot(t,Vct)
title('the orginal signal & Envelope detector output of AM signal "practical"'); 
xlabel('time (s)'); 
ylabel('amplitude');
legend('mt','Vct')
subplot(2,1,2)
plot (f,abs(z))
hold on
subplot(2,1,2)
plot (f,abs(v))
title('Spectrum of the orginal signal & Envelope detector output'); 
xlabel('frequency (Hz)'); 
ylabel('amplitude');
legend('abs(z)','abs(v)')