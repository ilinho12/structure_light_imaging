%%
% This function is used to generate a sphere
% output is a data of Matlab Mat
% input is the input parameters of this function
%%
function z = mSphere(Dn, Da, Db, Dc, alpha, t)
% Input t is the physical distance of pixel
% Input Dn is the diameter of sphere
% Input Da is the diameter of the axit X
% Input Db is the diameter of the axit Y
% Input Dc is the diameter of the axit Z
% Input alpha is the moving coefficient of axit Z

%% Initialization
switch nargin
    case 0
        Dn = 512; Da = 400; Db = 400; Dc = 40; alpha =0.5; t = 1;
    case 1
        Dn = 512; Da = 400; Db = 400; Dc = 40; alpha =0.5;
    case 2
        Dn = 512; Da = 400; Db = 400; Dc = 40;
    case 3
        Dn = 512; Da = 400; Db = 400;
    case 4
        Dn = 512; Da = 400;
    case 5
        Dn = 512;
end
n = Dn/2;
a = Da/2;
b = Db/2;
c = Dc/2;

%% Generating spheren
z = zeros(2*n); % z is the height distribution of image
x = repmat(-n:n-1,Dn,1);
y = repmat(-n:n-1,Dn,1)';
a2 = a^2;
b2 = b^2;
c2 = c^2;
x2 = (x/t).^2;
y2 = (y/t).^2;
a2b2z2 = a2*b2*c2-b2*c2*x2-c2*a2*y2;
z2 = a2b2z2;
z2(z2<0) = 0;
z2 = z2./(a2*b2);
zp = sqrt(z2);
z = (zp-alpha*c)*t;
z(z<0) = 0;
% figure; surf(z); shading interp;
end



