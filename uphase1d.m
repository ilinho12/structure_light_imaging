function up=uphase1d(wp)
n=zeros(size(wp));
for i=2:length(wp)
    n(i)=floor((wp(i)-wp(i-1))/(2*pi)+0.5)+n(i-1);
end
up=-2*pi*n+wp;
end
