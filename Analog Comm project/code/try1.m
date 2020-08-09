Fs = 1e3;
t = 0:0.001:1;
ka1 = 0.4;
fm = 9;
fc = 50;
mt = cos(2*pi*fm*t);
ct = cos(2*pi*fc*t);
x = (1+ka1*mt).*ct;
%x = cos(2*pi*100*t)+sin(2*pi*202.5*t);
plot(t,x)

xdft = fft(x);
xdft = xdft(1:length(x)/2+1);
xdft = xdft/length(x);
xdft(2:end-1) = 2*xdft(2:end-1);
freq = 0:Fs/length(x):Fs/2;

figure
plot(freq,abs(xdft))
hold on
%plot(freq,ones(length(x)/2+1,1),'LineWidth',2)
xlabel('Hz')
ylabel('Amplitude')
hold off