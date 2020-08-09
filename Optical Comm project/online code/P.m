function PP=P(x,y,z,uf,ub)
% Define the function used in RK4.m
% USE: Element by Element Computation
%
%  y= Pp , Pump power
%  z= Ps , Signal power 
yc=0 ;
%
%
%----BEGIN:Fiber Parameters------------------------------------------------
global Nt;   %Er ion density in ion/m^3 
%  50ppm =2*(10^24) per cubic meter
%
global lambda_p   ;  %m
global lambda_s    ; %m
global sigma_pa ; %m^2
global sigma_pe   ; %m^2
global sigma_pe2  ; %m^2
global sigma_se   ; %m^2
global sigma_sa  ; %m^2
global A_21    ; %s^-1
global A_32   ; %s^-1
global AR   ; %m^2
global Gamma_s   ; % Signal to core overlap
global Gamma_p  ; % Pump to core overlap
global h            ; % J/s ; Planck's constant
global c_light  ; % m/s ; Velocity of light
global v_p    ;  %Hz, Pump frequency
global v_s   ;  %Hz, Signal frequency
global alpha_s; % Background loss at signal wavelength (per m)=0.25dB/km
global alpha_p ; % Background loss at pump wavelength (per m)=0.25dB/km
%
%
%----END:Fiber Parameters--------------------------------------------------
%
%
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
f= A_32.*Nt  ;
%
% NEXT : 
N1= -(c.*e -b.*f)./(a.*e -b.*d)   ;
N2= -(c.*d -a.*f) ./(b.*d -a.*e)  ;
N3= Nt- N1- N2;
%
% Finally:
PP= (-1)*(y.*Gamma_p).*(sigma_pa*N1 - sigma_pe2*N2 - sigma_pe*N3)- (alpha_p.*y );