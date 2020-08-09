function pdot=edfa3(l,po)
r=5e-06;
gammas= 0.8;
N=1e25;
lamdas=1550e-09;
A=pi.*r^2;
segmae=3.084e-25;
segmaa=2.277e-25;
t=10e-03;
Psin=1e-03;
c=3e8;
h=6.626e-34;
deltalamda=0.1e-09;
const1=(lamdas.*gammas.*segmae)/(A*h*c);
const2=(lamdas.*gammas.*segmaa)/(A*h*c);
N2=(const2.*Psin.*N)/((1/t)+((const1+const2).*Psin));
N1=N-N2;
pdot(1)=gammas.*(((-1*segmae.*N2)+segmaa.*N1)*po(1)+...
        (2*h*c^2*segmae.*N2.*deltalamda)/lamdas);
end