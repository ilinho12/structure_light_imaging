%%
% This function is used to make a highpass Butterworth filter for 2D image
%%
function H = filter_LBW(n, valueFilter, N, x0, y0)
% Input n is the size of filter matrix
% Input valueFilter is the threshold of filter
% Input N is the order of Butterworth filter
% Input (x0, y0) is the coordinate of center poin

%% Initialization
switch nargin
    case 0
        n = 512; valueFilter = 128; N = 1; x0 = n/2; y0 = n/2;
    case 1
        n = 512; valueFilter = 128; N = 1; x0 = n/2;
    case 2
        n = 512; valueFilter = 128; N = 1;
    case 3
        n = 512; valueFilter = 128;
    case 4
        n = 512;
end

%% Main function
H = zeros(n);
D0 = valueFilter;
for u = 1:n
    for v = 1:n
        D = sqrt((u-x0)^2+(v-y0)^2);
        H(u,v) = 1/(1+(D/D0)^(2*N));
    end
end

%[R,C]=meshgrid(1:R,1:C);
%surf(R,C,H);title('Highpass Butterworth filter ');shading interp
end