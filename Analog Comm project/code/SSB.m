fs = 120 ; %sample frequency
fc= 50 ;%carrier frequency
ts=1/fs;
t=0:ts:(N-1).*ts ;
m_t = cos(2*pi*9*t);% signal
c_t =cos(2*pi*fc*t);%carrier
c_t2=sin(2*pi*fc*t);
hil = hilbert(m_t);%heilbert transform
mh_t = imag(hil); %signal heilbert
usb=m_t.*c_t -(mh_t.*c_t2); %usb signal
usbzp =[m_t,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
N =length (usbzp);
df=fs/(N-1);
f=-60:df:60; %freq range
usbf =(ts/3).*fft(usbzp);
usbf_shifted=fftshift(usbf);
figure
plot(f,abs(usbf))
%demodulation 
signal = usb .*c_t ;
unmodf = (ts/3).*fft(signal);
rect=rectangularPulse(-9,9,f);
finalf = unmodf.*rect;
figure
plot(f,finalf)
finalt =fs.*ifft(finalf);
figure
subplot(2,1,1)
plot(t,m_t)
subplot(2,1,2)
plot(t,finalt)

