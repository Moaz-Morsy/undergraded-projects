


% Demodulation process 
function z=qamdemod8(y) 
yds = intdump(y,4); % Down-sampling 
yabs=abs(yds); 
yangle=angle(yds); 
for j=1:length(yds) 
    if yabs(j)<(1+sqrt(2)+sqrt(3))/2 
        if pi<yangle(j) && yangle(j)<=1.5*pi 
            z(j,1)=0; 
        elseif 1.5*pi<yangle(j) && yangle(j)<=2*pi
            z(j,1)=2; 
        elseif 0<yangle(j) && yangle(j)<=0.5*pi 
            z(j,1)=3; 
        else 
            z(j,1)=1; 
        end 
    else 
        if (5/4)*pi<yangle(j) && yangle(j)<=(7/4)*pi 
            z(j,1)=4; 
        elseif (-1/4)*pi<yangle(j) && yangle(j)<=(1/4)*pi 
            z(j,1)=6; 
        elseif (1/4)*pi<yangle(j) && yangle(j)<=(3/4)*pi 
            z(j,1)=7; 
        else 
            z(j,1)=5; 
        end 
    end 
end 
end

