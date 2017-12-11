function up=uphase2d(wp)
[r,c]=size(wp);
wp(1,:)=uphase1d(wp(1,:));
for n=1:c
    wp(:,n)=uphase1d(wp(:,n));
end
up=wp;
end