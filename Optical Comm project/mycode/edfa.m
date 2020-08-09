function pdot=edfa(l,p)
r=5e-06;
gammap= 0.4;
N=1e25;
lamdap=1480e-09;
A=pi.*r^2;
segmae=0.7899e-25;
segmaa=1.950e-25;
t=10e-03;
Pp=0.5;
c=3e8;
h=6.626e-34;
deltalamda=0.1e-09;
const1=(lamdap.*gammap.*segmae)/(A*h*c);
const2=(lamdap.*gammap.*segmaa)/(A*h*c);
N2=(const2.*Pp.*N)/((1/t)+((const1+const2).*Pp));
N1=N-N2;
pdot(1)=gammap.*((segmae.*N2-segmaa.*N1)*p(1)+...
        (2*h*c^2*segmae.*N2.*deltalamda)/lamdap);
end