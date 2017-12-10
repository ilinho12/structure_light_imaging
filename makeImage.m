% Generate an ellipsoid
function [ E_image, phase_grating, phase_add ] = makeImage
% a=200, b=200, c=30
hight = zeros(513, 513);
a_el = 200; b_el = 200; c_el = 30;
a2_el = a_el^2; b2_el = b_el^2; c2_el = c_el^2;
for ii = 1 : 512
    for jj = 1 : 512
        if (((ii-257)^2*b2_el+(jj-257)^2*a2_el) <= a2_el*b2_el)
            hight(ii,jj) = sqrt((a2_el*b2_el*c2_el-...
                b2_el*c2_el*(ii-257)^2-a2_el*c2_el*(jj-257)^2)...
                /(a2_el*b2_el));
        end
    end
end
figure; surf(hight, 'CDataMapping', 'scaled'); caxis auto; shading interp;

% Generate a sine grating
% T = 80, f = 1/80
T_grating = 80; f_grating = 1/T_grating;

I_grating = zeros(size(hight)); phase_grating = zeros(size(hight));
for jj = 1 : 512
     I_grating(:, jj) = 128+127*cos(2*pi*jj*f_grating);
     phase_grating(:, jj) = rem( 2*pi*jj*f_grating, 2*pi )/2/pi;
end

% theta is the angle of incidence
% lambda is the equivalent length
theta = pi/4;
lambda_eq = T_grating*sin(theta);

% E_angle_add is the additional phase's angle of image from object
E_image = zeros(size(hight));
E_phase = zeros(size(hight));
phase_add = zeros(size(hight));
for ii = 1 : 513
    for jj = 1 : 513
        phase_add(ii,jj) = hight(ii,jj)/lambda_eq;
        E_phase(ii,jj) = 2*pi*jj*f_grating+2*pi*phase_add(ii,jj);
        E_image(ii,jj) = 0.5+0.5*cos(E_phase(ii,jj));
    end  
end

%{
figure; image_grating = mat2gray(I_grating);
imshow(image_grating); title('image-grating');
imwrite(image_grating, 'test1.bmp');
%}

figure; 
E_image = mat2gray(E_image);
imshow(E_image); title('Input-image');
imwrite(E_image, 'test2.bmp');

figure; 
E_angle_phase = mod(E_phase/2/pi,1);
image(E_angle_phase, 'CDataMapping', 'scaled'); 
colormap(jet); title('Input-phace'); colorbar;

figure;
image(phase_add, 'CDataMapping', 'scaled'); caxis([0 1]) 
colormap(jet); title('Input-phace-add'); colorbar;

end
