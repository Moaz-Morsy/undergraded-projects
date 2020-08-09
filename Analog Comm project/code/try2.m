clear
clc
close all
fm = 9;
fc = 50;
%ka = [0.4,1.5];
ka1 = 0.4;
ka2 = 0.4;
ts = 0.003; 
t = 0:ts:3;
Mt = cos(2*pi*fm*t);
Ct = cos(2*pi*fc*t);
%for k=1:2
St1 =(1+(ka1*Mt)).*Ct;
Et1 =1+(ka1*Mt);
St2 =(1+(ka2*Mt)).*Ct;
Et2 =1+(ka2*Mt);

%RC = Et/(2*pi*fm*ka*sin(2*pi*fm*t));
%Emax = 1+ka;
%Vct = Et*(1-(t/(RC)));

subplot(3,1,1)
plot(t,St1)
subplot(3,1,2)
plot(t,St1)
hold on
subplot(3,1,2)
plot(t,Et1)
hold on
subplot(3,1,2)
%stem(t,St1)

Vct1(1) = St1(1);
Vct2(1) = St2(1);
%t1 =(0:length(St)-1).*ts;
%R=[10^5,10^4].*3.6;
R=10^4*4;
C=10^-6;
%for n=1:2
    for i=2:length(St1)
        if St1(i)>Vct1(i-1)
        Vct1(i)=St1(i);
        else
        %Vct1(i)= Vct1(i-1).*(exp(-ts/(R*C)));
        %Vct1(i)= Vct1(i-1).*(exp(-ts/(R*C)));
        Vct1(i)= Vct1(i-1).*(1-(ts/(R*C)));
        end
    end
    for i=2:length(St2)
        if St2(i)>Vct2(i-1)
        Vct2(i)=St2(i);
        else
        %Vct2(i)= Vct2(i-1).*(exp(-ts/(R*C)));
        %Vct2(i)= Vct2(i-1).*(exp(-ts/(R(n)*C)));
        Vct2(i)= Vct2(i-1).*(1-(ts/(0.09)));
        end
    end
subplot(3,1,3)
plot(t,St1)
hold on
subplot(3,1,3)
plot(t,Vct1)
hold on
subplot(3,1,3)
%stem(t,St1)
%end
%end

figure
subplot(3,1,1)
plot(t,St2)
subplot(3,1,2)
plot(t,St2)
hold on
subplot(3,1,2)
plot(t,Et2)
hold on
subplot(3,1,2)
%stem(t,St2)
subplot(3,1,3)
plot(t,St2)
hold on
subplot(3,1,3)
plot(t,Vct2)
hold on
subplot(3,1,3)
%stem(t,St2)