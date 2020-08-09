function podot=edfa2(l,po)
r=5e-06;
gammas=0.8;
N=1e25;
A=pi.*r^2;
lamdas=[1525 1530 1532 1535 1540 1545 1550 1552 1555 1560 1565]*10^-09;
segmae=[3.983 4.752 4.364 4.147 3.416 3.24 3.084 3.038 2.945 2.773 2.353]*10^-25;
segmaa=[4.538 4.613 4.244 3.298 2.853 2.57 2.277 2.150 1.960 1.676 1.286]*10^-25;
t=10e-03;
Pin=1e-03;
c=3e8;
h=6.626e-34;
deltalamda=0.1e-09;
%const1=(lamdas.*gammas.*segmae)/(A*h*c);
%const2=(lamdas.*gammas.*segmaa)/(A*h*c);
%N2=(const2.*Pin.*N)/((1/t)+((const1+const2).*Pin));
con1=sum(lamdas.*segmae);
con2=sum(lamdas.*segmaa);
const1=(gammas.*con1)/(A*h*c);
const2=(gammas.*con2)/(A*h*c);
N2=(const2.*Pin.*N)/((1/t)+((const1+const2).*Pin));
N1=N-N2;
for i=1:length(lamdas)
podot(1)=gammas.*((segmae(i).*N2-segmaa(i).*N1)*po(1)+...
        (2*h*c^2*segmae(i).*N2.*deltalamda)/lamdas(i));
end
end
