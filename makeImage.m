clear all;clc;close all;

% Generate an ellipsoid
% a=200, b=200, c=20
hight = zeros(512, 512);
for ii = 1 : 512
    for jj = 1 : 512
        if (((ii-256)^2+(jj-256)^2) < 4e4)
            hight(ii,jj) = sqrt(4e2-((ii-256)^2+(jj-256)^2)/1e2);
        end
    end
end
figure; surf(hight);

% Generate a sine grating
% T = 4, f = 1/4
T_grating = 4; f_grating = 1/T_grating;

I_grating = zeros(size(hight));
for jj = 1 : 512
     I_grating(:, jj) = 128+127*cos(2*pi*jj*f_grating);
end
figure; 
imshow(mat2gray(I_grating));

% theta is the angle of incidence
% lambda is the equivalent length
theta = pi/4;
lambda_eq = T_grating*sin(theta);

E_image = zeros(size(hight));
for ii = 1 : 512
    for jj = 1 : 512
     E_image(ii,jj) = 128+127*cos(2*pi*jj*f_grating+2*pi*hight(ii,jj)/lambda_eq);
    end  
end

figure; 
E_image = mat2gray(E_image);
imshow(E_image);
imwrite(E_image, 'test.bmp');