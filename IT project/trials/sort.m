clear 
close all
clc;
X = [ 13 15 5 5 0 0 0 1 0 3] ;
[sortedValue_X , X_Ranked] = sort(X,'descend');
[uniqueValues, ia, ic]=unique(sortedValue_X);

for m=1:length(p)
   for n=1:length(p)
       if p(m)==p(n)
       if(I(m)>I(n))
         a=I(n);  
         a1=p(n);
         I(n)=I(m);
         p(n)=p(m);  
         I(m)=a;   
         p(m)=a1;
       end
       end
   end
end