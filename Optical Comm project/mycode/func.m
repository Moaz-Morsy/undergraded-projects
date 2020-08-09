function xdot=func(t,x)
xdot(1)=x(2);
xdot(2)=-7*x(2)-10*x(1)+20;
xdot=xdot';
end