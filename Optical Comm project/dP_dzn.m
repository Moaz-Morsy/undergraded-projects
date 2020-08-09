function pdot=dP_dzn(l,pn,lamda,segmae,segmaa,x,y,z)
r=5e-06;
gammap=0.4;
gammas=0.8;
N=1e25;
A=pi.*r^2;
lamdap=1480e-09;
segmaep=0.7899e-25;
segmaap=1.950e-25;
%lamdas=1550e-09;
%segmaes=3.084e-25;
%segmaas=2.277e-25;
t=10e-03;
c=3e8;
h=6.626e-34;
deltalamda=0.1e-09;
const1=(gammas.*sum(x.*y))./(A*h*c);
const2=(gammas.*sum(x.*z))./(A*h*c);
const3=(lamdap.*gammap.*segmaep)/(A*h*c);
const4=(lamdap.*gammap.*segmaap)/(A*h*c);
N2=((const2.*pn(2)+const4.*pn(1)).*N)./((1/t)+const1.*pn(2)+...
const2.*pn(2)+const3.*pn(1)+const4.*pn(1));
N1=N-N2;
pdot(1)=(gammap.*((segmaep.*N2-segmaap.*N1).*pn(1)));
pdot(2)=(gammas.*((segmae.*N2-segmaa.*N1).*pn(2)+...
        (2*h*c^2*segmae.*N2.*deltalamda)/lamda)); ...
pdot=pdot';
end