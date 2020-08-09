clear all;
close all;
clc;
%% 256 shades of grey 
% 256x256 grayscale image with equiprobable 256 color 
killua=repmat(0:255,256,1);
colormap=zeros(256,3);
colormap(1,:)=0;
add=1/256;
for i=2:256
   colormap(i,:)=add;
   add=add+1/256;
end
imwrite(uint8(killua),colormap,'256_shades_of_grey.png');
RGB = imread('256_shades_of_grey.png');
imshow(RGB)
p=(colormap(:,1))';
s=(1:length(p))';
if length(s)~=length(p)
   error('Wrong entry.. enter again- ') 
end   
i=1;
for m=1:length(p)
   for n=1:length(p)
       if(p(m)>p(n))
         a=p(n);  a1=s(n);
         p(n)=p(m);s(n)=s(m);  
         p(m)=a;   s(m)=a1;
       end
   end
end
%display(p) %arranged prob. in descending order.
tempfinal=[0];
sumarray=[];
w=length(p);
lengthp=[w];
b(i,:)=p;
while(length(p)>2) 
 tempsum=p(length(p))+p(length(p)-1);
 sumarray=[sumarray,tempsum];
 p=[p(1:length(p)-2),tempsum];
 p=sort(p,'descend');
 i=i+1;
 b(i,:)=[p,zeros(1,w-length(p))];
 w1=0;
 lengthp=[lengthp,length(p)];
 
 for temp=1:length(p) 
     if p(temp)==tempsum;
       w1=temp;
     end
 end
 tempfinal=[w1,tempfinal];  % Find the place where tempsum has been inserted
 %display(p);
end
 sizeb(1:2)=size(b);
 tempdisplay=0;
 temp2=[];
 
 for i= 1:sizeb(2)   
  temp2=[temp2,b(1,i)];
 end 
 sumarray=[0,sumarray];
  var=[];
  e=1;
 for ifinal= 1:sizeb(2)
  code=[];
 for j=1:sizeb(1) 
     tempdisplay=0; 
    
 for i1=1:sizeb(2) 
    if( b(j,i1)==temp2(e))  
    tempdisplay=b(j,i1);     
  %end
    elseif(tempdisplay==0 && b(j,i1)==sumarray(j))
           tempdisplay=b(j,i1);
    end
 end
    var=[var,tempdisplay];
 if tempdisplay==b(j,lengthp(j))       %assign 0 & 1
     code=[code,'1'];
 elseif tempdisplay==b(j,lengthp(j)-1)
      code=[code,'0'];
 else
      code=[code,''];
 end 
      temp2(e)=tempdisplay;  
 end
  %display(fliplr(code)) %display final codeword
   codewords{ifinal,1} = s(ifinal);
   codewords{ifinal,2} = fliplr(code);
   Codewords =flip(codewords);
   e=e+1;
 end
 %% encoding
 encodingword=cell2mat(Codewords{2});
 sizeRGB(1:2)=size(RGB);
  RGBcoded=cell(sizeRGB(1),1);
 for n=1:sizeRGB(1)
     for m=1:sizeRGB(2)
         currentcodeword=codewords((cell2mat(codewords(:,1))== RGB(n,m)),2);
         RGBcoded(n,1)=RGBcoded(n,1)+currentcodeword;
     end
 end
 
 