clear; close all;
% This function is a test script in the programming of author;

%% Initialization
n = 512; % n is the length of maxtrix 
t = 1; % t is the physical distance of pixel
theta = pi/10; % theta is the angle of incidence
T_grating = 80; % T_grating is the period of grating
lambda_eq = T_grating*sin(theta); % lambda_eq is the equivalent
                                  % wave length
%% Generating a sphere 3D object
obj = mSphere;
hight = obj;

%% Generating a grating
[grating, phase_grating] = mGrating;

%% Mixing the image of object and grating
E_image = zeros(n);
phase_image = zeros(n);
angle_phase = zeros(n);
angle_phase_add = zeros(n);
for ii = 1 : n
    for jj = 1 : n
        angle_phase_add(ii,jj) = 2*pi*hight(ii,jj)/lambda_eq;
        phase_image(ii,jj) = phase_grating(ii,jj) + angle_phase_add(ii,jj);
        angle_phase(ii,jj) = rem( phase_image(ii,jj), 2*pi ) - pi;
        E_image(ii,jj) = 0.5+0.5*cos(phase_image(ii,jj));
    end
end

figure; imshow(E_image); 
figure;
image(angle_phase, 'CDataMapping', 'scaled'); caxis([-pi pi]); 
colormap(jet); title('Input-phace'); colorbar;
