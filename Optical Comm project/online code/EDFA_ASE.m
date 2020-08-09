% NUMERICAL CALCULATION OF THULIUM DOPED FIBER AMPLIFIER
% NUMERICAL SOLUTION OF ORDINARY DIFFERENTIAL EQUATION (ODE):
% RUNGE-KUTTA METHOD OF ORDER 4 for ODE SYSTEMS
% RELAXATION METHOD
%=============================================
%   % Written by : Siamak Dawazdah Emami
%   % Dated : Published Dated : 26 May 2015
%=============================================
% For more information you can refer to following published papers:
% William J. Miniscalco "Erbium-Doped Glasses for Fiber Amplifiers  at 1500  nm",
% JOURNAL OF  LIGHTWAVE TECHNOLOGY, VOL. 9. NO. 2, FEBRUARY 1991 
% 
% S. D. Emami, H. A. A. Rashid, F. Z. Zahedi, M. C. Paul, S. Das, M. Pal
% and S.W. Harun ?Investigation of the bending sensitivity of partially 
% erbium-doped core fibres ?IEEE Sensors Journal, vol. 14,  no. 4, pp. 
% 1295, APRIL 2014
% 
% S. D. Emami, H. A. Abdul-Rashid, H. Ahmad, A. Ahmadi, and S. W. Harun, 
% "Effect of transverse distribution profile of thulium on the performance of
% thulium-doped fibre amplifiers," Ukraine Journal of Physic Optic vol. 13, 
% pp.74-81, 2012.
%===========================================================
clear
clc           % Clear the screen
format long
tic 
%
%-----PARAMETER INITIALIZATION------------------------------
%  NOTE :  Enter/Change your parameters here.
%
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
FiberLength= 14 ; %m
n=140 ;          % No of Steps / No. of loops
hSTEP=(FiberLength-0)/n;           % h is step size, 
% (dy/dx)= y'= K(x,y,z);   where y(t=a)=yo and a<x<b
% (dz/dx)= z'= M(x,y,z);   where z(t=a)=yo and a<x<b
x_initial = 0  ;         % x=zl longitudinal distance
y_initial = 20*10^-3  ; % y= Pp , Pump power (W) ; Pp=20mW
yc=0 ;   % yc=Pp(counter):Counterpropagating Pump(W)
z_initial = 1*(10^-7) ;       % z= Ps , Signal power (W);
%Using Ps= -40dBm =(1*10^-4)mW
%
ASE_F1= 0 ;  % Forward ASE  
uf=ASE_F1 ;
ub=0;        % Backward ASE
%
%
%----BEGIN:Fiber Parameters------------------------------------------------
Nt= 4*(10^24);   %Er ion density in ion/m^3 
%  50ppm =2*(10^24) per cubic meter
%
lambda_p =1480*(10^-9)   ;  %m
lambda_s =1550*(10^-9) ;   %m
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------FORMULATION OF PROBLEM------------------------------------
% 
%  y= Pp , Pump power
%  z= Ps , Signal power 
% From Desurvire's Paper 
% (JOURNAL OF LIGHTWAVE TECHNOLOGY, Vol9, No.2, February 1991)
%
%-----------------------------------------------------------------
% dN1/dt = -AA*N1+ BB*N2 + C*N3 ;  ----Equation (1)
% dN2/dt = DD*N1 - EE*N2 + A_32*N3 ; ------Equation (2);
% N3= Nt - N1 - N2 ; ------- Equation (3)
% where 
%AA=(sigma_sa*Gamma_s)./(h*v_s*AR).*(z+uf+ub) + (sigma_pa*Gamma_p)./(h*v_p*AR).*(y+yc)  ;
%BB=(sigma_se*Gamma_s)./(h*v_s*AR).*(z+uf+ub) +A_21 + (sigma_pe2*Gamma_p)./(h*v_s*AR).*(y+yc) ;
%CC=(sigma_pe*Gamma_p)./(h*v_p*AR) .*(y+yc) ;
%DD=(sigma_sa*Gamma_s)./(h*v_s*AR).*(z+uf+ub) ;
%EE=(sigma_se*Gamma_s)./(h*v_s*AR).*(z+uf+ub) + A_21 + (sigma_pe2*Gamma_p)./(h*v_p*AR).*(y+yc) ;
% Also define :
% a= -(AA+CC) ;
% b= BB-CC ;
% c= CC.*Nt ;
% d= DD-A_32 ;
% e= -(EE+A_32) ;
% f= A_32.*Nt ;
%
% NEXT : 
% N1= -(c.*e -b.*f)./(a.*e -b.*d)   ;
% N2= -(c.*d -a.*f) ./(b.*d -a.*e)  ;
% N3= Nt- N1- N2;
            
%==================MATHLAB CODE============================================
%==Code for FIRST-Pass : Pump, Signal and Forward ASE ONLY ! --------
%
x = x_initial ;
y = y_initial ;
z = z_initial ;
%
LL1=[];
XX1=[x];
YY1=[y];
ZZ1=[z];
ASE_F1=[uf] ;
%
L1=0;
for w=0:n-1             % No. of loops
   LL1=[LL1,L1]; 
   L1=L1+1; 
   x=x+hSTEP;
   
   k1=hSTEP*feval('P1',x,y,z,uf);
   m1=hSTEP*feval('S1',x,y,z,uf);
   f1=hSTEP*feval('ASE_F1',x,y,z,uf); 
      
   k2=hSTEP*feval('P1',(x+0.5*hSTEP),(y+0.5*k1),(z+0.5*m1), (uf+0.5*f1)) ;
   m2=hSTEP*feval('S1',x+0.5*hSTEP,y+0.5*k1,z+0.5*m1, uf+0.5*f1) ;
   f2=hSTEP*feval('ASE_F1',x+0.5*hSTEP,y+0.5*k1,z+0.5*m1, uf+0.5*f1) ;
   
   
   k3=hSTEP*feval('P1',(x+0.5*hSTEP),(y+0.5*k2),(z+0.5*m2), (uf+0.5*f2) );
   m3=hSTEP*feval('S1',(x+0.5*hSTEP),(y+0.5*k2),(z+0.5*m2), (uf+0.5*f2) ) ;
   f3=hSTEP*feval('ASE_F1',(x+0.5*hSTEP),(y+0.5*k2),(z+0.5*m2), (uf+0.5*f2));
   
   
   k4=hSTEP*feval('P1',x+hSTEP,y+k3,z+m3,uf+f3 );
   m4=hSTEP*feval('S1',x+hSTEP,y+k3,z+m3,uf+f3 );
   f4=hSTEP*feval('ASE_F1',x+hSTEP,y+k3,z+m3,uf+f3 );
   
   
   y=y+(1/6)*(k1+2*(k2+k3)+k4);   % Pump values
   z=z+(1/6)*(m1+2*(m2+m3)+m4);   % Signal values
   uf= uf +(1/6)*(f1+2*(f2+f3)+f4);   % Forward ASE values
        
   XX1=[XX1,x];
   YY1=[YY1,y];
   ZZ1=[ZZ1,z];
   ASE_F1=[ASE_F1, uf] ;
   UF1=ASE_F1 ;
end
%
uf1=uf ;
x_FirstPass =x ;
y_FirstPass =y ;
z_FirstPass =z ;
%
x1 = x_FirstPass ;
y1 = y_FirstPass ;
z1 = z_FirstPass ;
%
Gain_1 = 10*log10(z1/z_initial) ;
Gain_1p = 10*log10(ZZ1./z_initial);
%
%
%%88888888888888888888888888888888888888888888888888888888888888888888888%%
%
%%== Code for following Passes : Pump, Signal, Forward ASE and Backward ASE
%% LOOPING to solve 2-point boundary value problem where the boundary 
% for the points are at the beginning-point and end-point.
%
Gain_Difference = 10 ;  %Arbitrarily set by user to execute LOOPING below
%Has no physical meaning
%
LoopNumber = 0  ;
Gain_DifferenceData =[] ;
LoopNumberData = [] ; 
%
while Gain_Difference>=(1e-16) & LoopNumber<= 30    
    LL=[0];
XX=[x1];
YY=[y1];
ZZ=[z1];
uf=uf1 ;
ASE_FirstPass= uf ;
ASE_backward=0 ;
ub=ASE_backward ;
ASE_F1_R=[uf] ;
ASE_B1= [ub] ;
%
p=n-1 ;
L=1;
for w= p : -1 :0             % No. of loops
   LL=[LL,L]; 
   L=L+1; 
   x=x-hSTEP;  % Doing Reverse Integration from "L" to Zero(0)
   
   k21=hSTEP*feval('P',x,y,z,uf,ub);
   m21=hSTEP*feval('S',x,y,z,uf,ub);
   f21=hSTEP*feval('ASE_F',x,y,z,uf,ub); 
   b21=hSTEP*feval('ASE_B',x,y,z,uf,ub);  
   
   k22=hSTEP*feval('P',(x+0.5*hSTEP),(y+0.5*k21),(z+0.5*m21), (uf+0.5*f21),(ub+0.5*b21));
   m22=hSTEP*feval('S',x+0.5*hSTEP,y+0.5*k21,z+0.5*m21, uf+0.5*f21, ub+0.5*b21);
   f22=hSTEP*feval('ASE_F',x+0.5*hSTEP,y+0.5*k21,z+0.5*m21, uf+0.5*f21, ub+0.5*b21);
   b22=hSTEP*feval('ASE_B',x+0.5*hSTEP,y+0.5*k21,z+0.5*m21, uf+0.5*f21, ub+0.5*b21);
   
   k23=hSTEP*feval('P',(x+0.5*hSTEP),(y+0.5*k22),(z+0.5*m22), (uf+0.5*f22), (ub+0.5*b22));
   m23=hSTEP*feval('S',(x+0.5*hSTEP),(y+0.5*k22),(z+0.5*m22), (uf+0.5*f22), (ub+0.5*b22));
   f23=hSTEP*feval('ASE_F',(x+0.5*hSTEP),(y+0.5*k22),(z+0.5*m22), (uf+0.5*f22), (ub+0.5*b22));
   b23=hSTEP*feval('ASE_B',(x+0.5*hSTEP),(y+0.5*k22),(z+0.5*m22), (uf+0.5*f22), (ub+0.5*b22));
   
   k24=hSTEP*feval('P',x+hSTEP,y+k23,z+m23,uf+f23,ub+b23);
   m24=hSTEP*feval('S',x+hSTEP,y+k23,z+m23,uf+f23,ub+b23);
   f24=hSTEP*feval('ASE_F',x+hSTEP,y+k23,z+m23,uf+f23,ub+b23);
   b24=hSTEP*feval('ASE_B',x+hSTEP,y+k23,z+m23,uf+f23,ub+b23);
   
   y=y-(1/6)*(k21+2*(k22+k23)+k24);   % Pump values
   z=z-(1/6)*(m21+2*(m22+m23)+m24);   % Signal values
   uf= uf -(1/6)*(f21+2*(f22+f23)+f24);   % Forward ASE values
   ub= ub -(1/6)*(b21+2*(b22+b23)+b24);   % Backward ASE values
     
   XX=[XX,x];
   YY=[YY,y];
   ZZ=[ZZ,z];
   ASE_F1_R=[ASE_F1_R, uf] ;
   UF1_R=ASE_F1_R ;
   ASE_B1=[ASE_B1, ub] ;
   UB1=ASE_B1 ;
end
ub1=ub ;
%----------------------End of Part-2 --------------------------------------
%--------Part-3 -----------------------------------------------------------
x = x_initial ;
y = y_initial ;
z = z_initial ;
%
LL2=[0];
XX2=[x];
YY2=[y];
ZZ2=[z];
uf=0 ;
ub=ub1 ;
ASE_F2=[uf] ;
ASE_B1_R= [ub] ;
%
%
L=1;
for w= 0:n-1            % No. of loops
   LL=[LL,L]; 
   L=L+1; 
   x=x+hSTEP;  % The integration is from zero(0) to L
   
   k31=hSTEP*feval('P',x,y,z,uf,ub);
   m31=hSTEP*feval('S',x,y,z,uf,ub);
   f31=hSTEP*feval('ASE_F',x,y,z,uf,ub); 
   b31=hSTEP*feval('ASE_B',x,y,z,uf,ub);  
   
   k32=hSTEP*feval('P',(x+0.5*hSTEP),(y+0.5*k31),(z+0.5*m31), (uf+0.5*31),(ub+0.5*b31));
   m32=hSTEP*feval('S',x+0.5*hSTEP,y+0.5*k31,z+0.5*m31, uf+0.5*f31, ub+0.5*b31);
   f32=hSTEP*feval('ASE_F',x+0.5*hSTEP,y+0.5*k31,z+0.5*m31, uf+0.5*f31, ub+0.5*b31);
   b32=hSTEP*feval('ASE_B',x+0.5*hSTEP,y+0.5*k31,z+0.5*m31, uf+0.5*f31, ub+0.5*b31);
   
   k33=hSTEP*feval('P',(x+0.5*hSTEP),(y+0.5*k32),(z+0.5*m32), (uf+0.5*f32), (ub+0.5*b32));
   m33=hSTEP*feval('S',(x+0.5*hSTEP),(y+0.5*k32),(z+0.5*m32), (uf+0.5*f32), (ub+0.5*b32));
   f33=hSTEP*feval('ASE_F',(x+0.5*hSTEP),(y+0.5*k32),(z+0.5*m32), (uf+0.5*f32), (ub+0.5*b32));
   b33=hSTEP*feval('ASE_B',(x+0.5*hSTEP),(y+0.5*k32),(z+0.5*m32), (uf+0.5*f32), (ub+0.5*b32));
   
   k34=hSTEP*feval('P',x+hSTEP,y+k33,z+m33,uf+f33,ub+b33);
   m34=hSTEP*feval('S',x+hSTEP,y+k33,z+m33,uf+f33,ub+b33);
   f34=hSTEP*feval('ASE_F',x+hSTEP,y+k33,z+m33,uf+f33,ub+b33);
   b34=hSTEP*feval('ASE_B',x+hSTEP,y+k33,z+m33,uf+f33,ub+b33);
   
   y=y+(1/6)*(k31+2*(k32+k33)+k34);   % Pump values
   z=z+(1/6)*(m31+2*(m32+m33)+m34);   % Signal values
   uf= uf +(1/6)*(f31+2*(f32+f33)+f34);   % Forward ASE values
   ub= ub +(1/6)*(b31+2*(b32+b33)+b34);   % Backward ASE values
     
   XX2=[XX2,x];
   YY2=[YY2,y];
   ZZ2=[ZZ2,z];
   ASE_F2=[ASE_F2, uf] ;
   UF2=ASE_F2 ;
   ASE_B1_R=[ASE_B1_R, ub] ;
   UB1_R=ASE_B1_R ;
end
%
uf2=uf ;
Gain_2=10*log10(z/z_initial) ;
Gain_2p=10*log10(ZZ2./z_initial) ;
%
%-------------------------End of Part-3------------------------------------
%
%
%---Part-4 ----------------------------------------------------------------
% Doing reverse integration from L to zero(0).
LL=[0];
XX=[x1];
YY=[y1];
ZZ=[z1];
uf=uf2 ;
ASE_FirstPass= uf ;
ASE_backward=0 ;
ub=ASE_backward ;
ASE_F2_R=[uf] ;
ASE_B2= [ub] ;
%
p=n-1 ;
L=1;
for w= p : -1 :0             % No. of loops
   LL=[LL,L]; 
   L=L+1; 
   x=x-hSTEP;  % Reverse the integration from "L" to 0
   
   k21=hSTEP*feval('P',x,y,z,uf,ub);
   m21=hSTEP*feval('S',x,y,z,uf,ub);
   f21=hSTEP*feval('ASE_F',x,y,z,uf,ub); 
   b21=hSTEP*feval('ASE_B',x,y,z,uf,ub);  
   
   k22=hSTEP*feval('P',(x+0.5*hSTEP),(y+0.5*k21),(z+0.5*m21), (uf+0.5*f21),(ub+0.5*b21));
   m22=hSTEP*feval('S',x+0.5*hSTEP,y+0.5*k21,z+0.5*m21, uf+0.5*f21, ub+0.5*b21);
   f22=hSTEP*feval('ASE_F',x+0.5*hSTEP,y+0.5*k21,z+0.5*m21, uf+0.5*f21, ub+0.5*b21);
   b22=hSTEP*feval('ASE_B',x+0.5*hSTEP,y+0.5*k21,z+0.5*m21, uf+0.5*f21, ub+0.5*b21);
   
   k23=hSTEP*feval('P',(x+0.5*hSTEP),(y+0.5*k22),(z+0.5*m22), (uf+0.5*f22), (ub+0.5*b22));
   m23=hSTEP*feval('S',(x+0.5*hSTEP),(y+0.5*k22),(z+0.5*m22), (uf+0.5*f22), (ub+0.5*b22));
   f23=hSTEP*feval('ASE_F',(x+0.5*hSTEP),(y+0.5*k22),(z+0.5*m22), (uf+0.5*f22), (ub+0.5*b22));
   b23=hSTEP*feval('ASE_B',(x+0.5*hSTEP),(y+0.5*k22),(z+0.5*m22), (uf+0.5*f22), (ub+0.5*b22));
   
   k24=hSTEP*feval('P',x+hSTEP,y+k23,z+m23,uf+f23,ub+b23);
   m24=hSTEP*feval('S',x+hSTEP,y+k23,z+m23,uf+f23,ub+b23);
   f24=hSTEP*feval('ASE_F',x+hSTEP,y+k23,z+m23,uf+f23,ub+b23);
   b24=hSTEP*feval('ASE_B',x+hSTEP,y+k23,z+m23,uf+f23,ub+b23);
   
   y=y-(1/6)*(k21+2*(k22+k23)+k24);   % Pump values
   z=z-(1/6)*(m21+2*(m22+m23)+m24);   % Signal values
   uf= uf -(1/6)*(f21+2*(f22+f23)+f24);   % Forward ASE values
   ub= ub -(1/6)*(b21+2*(b22+b23)+b24);   % Backward ASE values
     
   XX=[XX,x];
   YY=[YY,y];
   ZZ=[ZZ,z];
   ASE_F2_R=[ASE_F2_R, uf] ;
   UF2_R=ASE_F2_R ;
   ASE_B2=[ASE_B2, ub] ;
   UB2=ASE_B2 ;
end
ub2=ub ;
%----------------------End of Part-4---------------------------------------
%--------Part-5 -----------------------------------------------------------
x = x_initial ;
y = y_initial ;
z = z_initial ;
%
LL2=[0];
XX2=[x];
YY2=[y];
ZZ2=[z];
uf=0 ;
ub=ub2 ;
ASE_F3=[uf] ;
ASE_B2_R= [ub] ;
%
%
L=1;
for w= 0:n-1            % No. of loops
   LL=[LL,L]; 
   L=L+1; 
   x=x+hSTEP;  % The integration is from zero(0) to L
   
   k31=hSTEP*feval('P',x,y,z,uf,ub);
   m31=hSTEP*feval('S',x,y,z,uf,ub);
   f31=hSTEP*feval('ASE_F',x,y,z,uf,ub); 
   b31=hSTEP*feval('ASE_B',x,y,z,uf,ub);  
   
   k32=hSTEP*feval('P',(x+0.5*hSTEP),(y+0.5*k31),(z+0.5*m31), (uf+0.5*31),(ub+0.5*b31));
   m32=hSTEP*feval('S',x+0.5*hSTEP,y+0.5*k31,z+0.5*m31, uf+0.5*f31, ub+0.5*b31);
   f32=hSTEP*feval('ASE_F',x+0.5*hSTEP,y+0.5*k31,z+0.5*m31, uf+0.5*f31, ub+0.5*b31);
   b32=hSTEP*feval('ASE_B',x+0.5*hSTEP,y+0.5*k31,z+0.5*m31, uf+0.5*f31, ub+0.5*b31);
   
   k33=hSTEP*feval('P',(x+0.5*hSTEP),(y+0.5*k32),(z+0.5*m32), (uf+0.5*f32), (ub+0.5*b32));
   m33=hSTEP*feval('S',(x+0.5*hSTEP),(y+0.5*k32),(z+0.5*m32), (uf+0.5*f32), (ub+0.5*b32));
   f33=hSTEP*feval('ASE_F',(x+0.5*hSTEP),(y+0.5*k32),(z+0.5*m32), (uf+0.5*f32), (ub+0.5*b32));
   b33=hSTEP*feval('ASE_B',(x+0.5*hSTEP),(y+0.5*k32),(z+0.5*m32), (uf+0.5*f32), (ub+0.5*b32));
   
   k34=hSTEP*feval('P',x+hSTEP,y+k33,z+m33,uf+f33,ub+b33);
   m34=hSTEP*feval('S',x+hSTEP,y+k33,z+m33,uf+f33,ub+b33);
   f34=hSTEP*feval('ASE_F',x+hSTEP,y+k33,z+m33,uf+f33,ub+b33);
   b34=hSTEP*feval('ASE_B',x+hSTEP,y+k33,z+m33,uf+f33,ub+b33);
   
   y=y+(1/6)*(k31+2*(k32+k33)+k34);   % Pump values
   z=z+(1/6)*(m31+2*(m32+m33)+m34);   % Signal values
   uf= uf +(1/6)*(f31+2*(f32+f33)+f34);   % Forward ASE values
   ub= ub +(1/6)*(b31+2*(b32+b33)+b34);   % Backward ASE values
     
   XX2=[XX2,x];
   YY2=[YY2,y];
   ZZ2=[ZZ2,z];
   ASE_F3=[ASE_F3, uf] ;
   UF3=ASE_F3 ;
   ASE_B2_R=[ASE_B2_R, ub] ;
   UB2_R=ASE_B2_R ;
end
uf3=uf ;
ub_2_r =ub ;
z_final=z ; % Final Signal Power
Gain_3=10*log10(z/z_initial) ; 
Gain_3p=10*log10(ZZ2./z_initial) ;
%
Gain_Difference = abs(Gain_3-Gain_2) ;
%
%-------------------------End of Part-5------------------------------------
    LoopNumber = (LoopNumber + 1) ;
    LoopNumberData = [LoopNumberData,LoopNumber]  ;
    Gain_DifferenceData =[Gain_DifferenceData ,Gain_Difference] ;    
    LoopNumber_Gain_Difference = [LoopNumberData ; Gain_DifferenceData]' ;
    Gain_dB=Gain_3 ;
end
%
LoopNumber_Gain_Difference ;
Gain_dB=[Gain_1,Gain_2,Gain_3];
disp('First step gain:')
disp(Gain_dB(1))
disp('Secound step gain:')
disp(Gain_dB(2) )
disp('Gain after relaxation method:')
disp(Gain_dB(3))
%
%%%888888888888888888888888888888888888888888888888888888888888888888888%%%
%
%===To compute N1, N2 and N3==============================
AA1=(sigma_sa*Gamma_s)./(h*v_s*AR).*(ZZ2+UF2+UB2) + (sigma_pa*Gamma_p)./(h*v_p*AR).*(YY2+yc)  ;
BB1=(sigma_se*Gamma_s)./(h*v_s*AR).*(ZZ2+UF2+UB2) +A_21 + (sigma_pe2*Gamma_p)./(h*v_s*AR).*(YY2+yc) ;
CC1=(sigma_pe*Gamma_p)./(h*v_p*AR) .*(YY2+yc) ;
DD1=(sigma_sa*Gamma_s)./(h*v_s*AR).*(ZZ2+UF2+UB2) ;
EE1=(sigma_se*Gamma_s)./(h*v_s*AR).*(ZZ2+UF2+UB2) + A_21 + (sigma_pe2*Gamma_p)./(h*v_p*AR).*(YY2+yc) ;
% Also define :
a1= -(AA1+CC1) ;
b1= BB1-CC1 ;
c1= CC1.*Nt ;
d1= DD1-A_32 ;
e1= -(EE1+A_32) ;
f1= A_32.*Nt ;
%
% NEXT : 
N1= -(c1.*e1 -b1.*f1)./(a1.*e1 -b1.*d1)   ;
N2= -(c1.*d1 -a1.*f1) ./(b1.*d1 -a1.*e1)  ;
N3= Nt- N1- N2;
%
%
% NEXT : 
N2toN1_ratio =N2./N1 ;
%Diff_N2andN1 = N2 - N1 ;
%
%
%===============OUTPUT=============================================
figure (1)
subplot(2,2,1)
plot(XX2,Gain_3p,'--r','linewidth',2.5);
xlabel('Fiber length (m)') % x-axis label
ylabel('Gain (dB))') % y-axis label
subplot(2,2,2)
plot(XX,UB2,XX1,UF3,'--r','linewidth',2.5);
xlabel('Fiber length (m)') % x-axis label
ylabel('Signal ASE (mW)') % y-axis label
legend('Forward ASE','Backward ASE')
subplot(2,2,3)
plot(XX1,ZZ2,'linewidth',2.5);
xlabel('Fiber length (m)') % x-axis label
ylabel('Signal Power(mW)') % y-axis label
subplot(2,2,4)
plot(XX1,YY2,'linewidth',2.5);
xlabel('Fiber length (m)') % x-axis label
ylabel('Pump Power (mW)') % y-axis label
%
%--------------------------------------------------------------
figure (2)
%
subplot(2,2,1)
plot(XX2,N1,'linewidth',2.5)
xlabel('Fiber length (m)') % x-axis label
ylabel('N_1 Popilation') % y-axis label
subplot(2,2,2)
plot(XX2,N2,'r','linewidth',2.5)
xlabel('Fiber length (m)') % x-axis label
ylabel('N_2 Popilation') % y-axis label
subplot(2,2,3)
plot(XX2,N3,'linewidth',2.5)
xlabel('Fiber length (m)') % x-axis label
ylabel('N_3 Popilation') % y-axis label
subplot(2,2,4)
plot(XX2,N2toN1_ratio,'linewidth',2.5)
xlabel('Fiber length (m)') % x-axis label
ylabel('N_2 to N_1 ratio') % y-axis label
%plot(XX2,Diff_N2andN1,'r')
%plot(XX2,YY2,'r')
%
%-----------To calculate Noise Figure ------------------
delta_v_s =3100*10^9 ; % Hertz (delta_lambda =25nm)
FINAL_Forward_ASE =10*log10(uf3) ;  % The value is in dBm
Final_Forward_ASE_dBm = FINAL_Forward_ASE 
h=6.626*(10^-34) ;
%Gain=Gain_3;
G=Gain_3   ;
% Use Gain (G) = Ps(out) / Ps(in)
% Use Gain in dB (G_dB) = 10_log10(G)
FinalPower=10^(G/10) ;  
P=FinalPower;
%   n_sp = P_ASE_forward/(2*h*(v_s)*(delta_v_s)*(Gain_3-1))
 SS=(2*h*(v_s)*(delta_v_s)*(P-1));
   n_sp = (uf3)/SS;
%Noise Figure (NF) = (1/G)*(2*n_sp*(G-1)+1);
%Noise Figure (NF) = (1/G)*((P_ASE_forward/h*(delta_v_s)*v_s)+1);
Noise_Figure = (1/P)*(2*n_sp*(P-1)+1) ;
TT=h*(delta_v_s)*v_s ;
Noise_Figure_1 = (1/P)*(1+(uf3/TT)) ;
Noise_Figure_dB=10*log10( Noise_Figure_1 )
%========================The End=========================
ExecutionTime=toc
%