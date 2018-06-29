%%
% This function is a test script in the programming of author;
%%
function [E_image2, E_grating] = testMakeImage2
    clear; close all;

    %% Initialization
    n = 512; % n is the length of maxtrix 
    t = 1; % t is the physical distance of pixel
    theta = pi/10; % theta is the angle of incidence
    T_grating = 80; % T_grating is the period of grating
    lambda_eq = T_grating*sin(theta); % lambda_eq is the equivalent
                                      % wave length
    frame = 2; % frame is the measurement time

    %% Generating a sphere 3D object
    obj = mSphere;
    hight = obj;

    E_image2 = zeros(n, n, frame);
    E_grating = zeros(n, n, frame);
    for kk = 1 : frame
        %% Generating a grating
        [grating, phase_grating] = mGrating(kk);

        %% Mixing the image of object and grating
        E_image = zeros(n,n);
        angle_phase_add = 2*pi*hight/lambda_eq;
        phase_image = phase_grating + angle_phase_add;
        angle_phase = rem( phase_image, 2*pi ) - pi;
        for ii = 1 : n
            for jj = 1 : n
                E_image(ii,jj) = 0.5+0.5*cos(phase_image(ii,jj));
            end
        end
        E_image2(:,:,kk) = E_image;
        E_grating(:,:,kk) = grating;
    %{
        figure; imshow(E_image); 
        figure;
        image(angle_phase, 'CDataMapping', 'scaled'); caxis([-pi pi]); 
        colormap(jet); title('Input-phace'); colorbar;
    %}
    end
end
%%