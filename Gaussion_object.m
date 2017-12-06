clc;
 clear all;
 %Generate sine grating T=8,f0=1/8
 I=zeros(512,512);
 for i=1:512
   for j=1:512
     I(i,j)=128+127*cos(i/8*2*pi);
   end  
 end
 I1=mat2gray(I);
 
 %Generate an Gaussion object
 h=zeros(512,512);
 for i=1:512
     for j=1:512
       h(i,j)=50*exp(-(((i-256)^2/(2*100^2)+(j-256)^2/(2*100^2))));
     end
 end
 surf(h);
 h1=mat2gray(h);
 
 
 %Generate energy distribution based on height
 E=zeros(512,512);
for i=1:512
   for j=1:512
     E(i,j)=128+127*cos(i/8*2*pi+2*pi/8*350/800*h(i,j));
   end  
 end
E1=mat2gray(E);
 figure(2),imshow(E1);
 
%FFT&&Filter 
F=fftshift(fft2(I1));
F1=log(1+abs(F));
G=fftshift(fft2(E1));
G1=log(1+abs(G));
figure(3);
subplot(121),imshow(F1);
subplot(122),imshow(G1);


rect_window_filter=zeros(size(G));
figure(4),p=contour(G1,400);
imshow(G1);
r=round(getrect);
rect_window_filter=zeros(size(F1));
rect_window_filter(r(2):r(4)+r(2),r(1):r(3)+r(1))=1;
Q=rect_window_filter.*G;
Qreff=rect_window_filter.*G1;

Q0=F.*rect_window_filter;
s0=ifft2(ifftshift(Q0));
s=ifft2(ifftshift((Q)));
Deltaphi=atan2(imag(s.*conj(s0)),real(s.*conj(s0)));
up=uphase2d(Deltaphi);
recovery_object=-800.*up./(2*pi/8*350-up);
figure(5);
surf(recovery_object);
 T=h-recovery_object;
 figure(6);
 surf(T);
 