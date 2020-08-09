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
sym=unique(RGB);
%prob=sym;
sizergb(1:2)=size(RGB);
for s=1:length(sym)
    i=find(RGB==sym(s));
    prob(s)=length(i)/(sizergb(1).*sizergb(2));
end