%% 
% This function a Lowpass Butterworth Transfer Function to the 2D image
%%
function img_out = cut_lft_BW( a, b, c_x, c_y, image, N )
% Input:
% a - cols radius (Y axis)
% b - rows radius (X axis)
% c_x - the cols of centre point
% c_y - the rows of centre point
% image - the input of two-dimensional real matrix
% H - operator
% D0 - passband radius
% N - order number of Butterworth

%% Initialization
[rows, cols] = size(image);
img_out = zeros(rows, cols);

%% Butterworth Operator
H=zeros(rows, cols);
D0 = a*b; 
a2 = a^2; b2 = b^2;
for u = 1:rows
    for v = 1:cols
        D = sqrt(b2*(u-c_y)^2 + a2*(v-c_x)^2);
        H(u, v) = 1/(1+(D/D0)^(2*N));
    end
end

%% Filter
img_out = image.*H; 

end