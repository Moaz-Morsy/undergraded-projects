function PB=ASE_B(x,y,z,uf,ub)
% Define the function used in RK4.m
% USE: Element by Element Computation
%
%  y= Pp , Pump power
%  z= Ps , Signal power 
yc=0  ;
%
%----BEGIN:Fiber Parameters------------------------------------------------
Nt= 4*(10^24);   %Er ion density in ion/m^3 
%  50ppm =2*(10^24) per cubic meter
%
lambda_p =1480*(10^-9)   ;  %m
lambda_s =1550*(10^-9)   ; %m
sigma_pa =2.787671*(10^-21)*(10^-4)  ; %m^2
sigma_pe =0.8105639*(10^-21)*(10^-4)  ; %m^2
sigma_pe2 =0.8105639*(10^-21)*(10^-4) ; %m^2
sigma_se =4.118853*(10^-21)*(10^-4)  ; %m^2
sigma_sa =2.91056*(10^-21)*(10^-4)  ; %m^2
A_21 =100   ; %s^-1
A_32 =10^9  ; %s^-1
AR =1.633*(10^-11)   ; %m^2
Gamma_s =0.74  ; % Signal to core overlap
Gamma_p =0.77 ; % Pump to core overlap
h=6.626*(10^-34)             ; % J/s ; Planck's constant
c_light=3.0*(10^8)  ; % m/s ; Velocity of light
v_p =c_light/lambda_p   ;  %Hz, Pump frequency
v_s =c_light/lambda_s   ;  %Hz, Signal frequency
alpha_s=5.76e-5 ; % Background loss at signal wavelength (per m)=0.25dB/km
alpha_p=5.76e-5  ; % Background loss at pump wavelength (per m)=0.25dB/km
%
%
%----END:Fiber Parameters--------------------------------------------------
%
delta_v =3.1e+012 ; %Hertz (3100Ghz) or 25nm
%delta_v =7.797565147399136e+012 ; %Hertz (3100Ghz) or 25nm
%---------------------------------------------
%
%  y= Pp , Pump power
%  yc= Pp(Counter) ; Counter-propagating pump power
%  z= Ps , Signal power 
%  uf : Forward ASE power
%  ub : Backward ASE power 
%
%---------------
%
AA=(sigma_sa*Gamma_s)./(h*v_s*AR).*(z+uf+ub) + (sigma_pa*Gamma_p)./(h*v_p*AR).*(y+yc)  ;
BB=(sigma_se*Gamma_s)./(h*v_s*AR).*(z+uf+ub) +A_21 + (sigma_pe2*Gamma_p)./(h*v_s*AR).*(y+yc) ;
CC=(sigma_pe*Gamma_p)./(h*v_p*AR) .*(y+yc) ;
DD=(sigma_sa*Gamma_s)./(h*v_s*AR).*(z+uf+ub) ;
EE=(sigma_se*Gamma_s)./(h*v_s*AR).*(z+uf+ub) + A_21 + (sigma_pe2*Gamma_p)./(h*v_p*AR).*(y+yc) ;
% Also define :
a= -(AA+CC) ;
b= BB-CC ;
c= CC.*Nt ;
d= DD-A_32 ;
e= -(EE+A_32) ;
f= A_32.*Nt ;
%
% NEXT : 
N1= -(c.*e -b.*f)./(a.*e -b.*d)   ;
N2= -(c.*d -a.*f) ./(b.*d -a.*e)  ;
N3= Nt- N1- N2;
%
% Finally:
PB= (-1).*(ub.*Gamma_s).*(sigma_se*N2 - sigma_sa*N1)-2.*sigma_se.*N2.*Gamma_s.*h*v_s.*delta_v +(alpha_s.*ub );